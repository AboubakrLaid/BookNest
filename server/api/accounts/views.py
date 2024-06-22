# from .models import User
from .serializers import (
    CreateUserSerializer,
    CompleteUserProfileSerializer,
    ResetPasswordSerializer,
)
from rest_framework.decorators import (
    api_view,
    permission_classes,
    authentication_classes,
    throttle_classes,
)
from rest_framework.permissions import IsAuthenticated, AllowAny
from .authentication import BearerTokenAuthentication
from rest_framework import status
from rest_framework.response import Response
from django.contrib.auth import authenticate, logout
from rest_framework.authtoken.models import Token
import requests
from django.core.mail import send_mail
from django.db.models import Q
from api.settings import EMAIL_HOST_USER
from random import randint as random_verification_code
from .models import EmailVerification, User, ResetPasswordVerification

# Create your views here.


def validate_email(email):
    # key = "53f9304ee2994fb2bc408fdc7928d4e4"
    # api_url = f"https://emailvalidation.abstractapi.com/v1/?api_key={key}&email={email}"
    # response = requests.get(api_url)
    # data = response.json()
    # if (
    #     data["is_valid_format"]["value"]
    #     and data["is_mx_found"]["value"]
    #     and data["is_smtp_valid"]["value"]
    #     and not data["is_catchall_email"]["value"]
    #     and not data["is_role_email"]["value"]
    #     and data["is_free_email"]["value"]
    # ):
    #     return True
    return True


@api_view(["POST"])
@permission_classes([AllowAny])
def register(request):

    email = request.data["email"]
    is_valid_email = validate_email(email)
    if is_valid_email:

        serializer = CreateUserSerializer(data=request.data)
        if serializer.is_valid():
            # create the user
            user = serializer.save()

            # mark user as has not being verified yet
            code = random_verification_code(10_00_00, 99_99_99)
            EmailVerification.objects.create(user=user, verification_code=code)

            token = Token.objects.create(user=user)
            return Response({"Token": token.key}, status=status.HTTP_201_CREATED)

        response_error = {
            "success": False,
            "errors": serializer.errors,
        }
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response(
        {"error": "invalid email address"}, status=status.HTTP_400_BAD_REQUEST
    )


@api_view(["POST"])
# @permission_classes([AllowAny])
def my_login(request):
    username = request.data.get("username")
    password = request.data.get("password")
    print(username, password)
    user = None
    user = authenticate(request=request, username=username, password=password)

    if user:
        # login(request=request, user=user)
        token, created = Token.objects.get_or_create(user=user)
        print(created)
        return Response({"Token": token.key}, status=status.HTTP_201_CREATED)

    return Response(
        {"error": "Invalid username or password"}, status=status.HTTP_401_UNAUTHORIZED
    )


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
@permission_classes([BearerTokenAuthentication])
def complete_register(request):
    print(request.data)
    serializer = CompleteUserProfileSerializer(request.user, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def my_logout(request):
    request.user.auth_token.delete()
    # Logout the user to clear session-based authentication (if any)
    logout(request)
    return Response({"logout": "success"}, status=status.HTTP_200_OK)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def send_email_verification_code(request):
    email = request.user.email
    user = request.user

    code = user.email_verification.verification_code
    send_mail(
        subject="verification code",
        message=f"this is your verification code {code}",
        from_email=EMAIL_HOST_USER,
        recipient_list=[email],
    )
    new_code = random_verification_code(10_00_00, 99_99_99)

    # generate new code in case of verification email failure
    user.email_verification.verification_code = new_code
    user.email_verification.save()
    # Ema
    return Response(
        {
            "success": True,
            "message": "A verification email has been sent to your email address. Please check your email to complete the registration process.",
        },
        status=status.HTTP_200_OK,
    )


@api_view(["GET"])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def verify_email(request):

    user = request.user
    verification_code = request.query_params.get("verification_code")

    if verification_code is None:
        return Response(
            {"error": "verification_code is required"},
            status=status.HTTP_400_BAD_REQUEST,
        )

    if verification_code == user.email_verification.verification_code:
        user.email_verification.delete()
        return Response(
            {"congrats": "email address verified successfuly"},
            status=status.HTTP_200_OK,
        )

    return Response(
        {"error": "invalid verification_code"},
        status=status.HTTP_400_BAD_REQUEST,
    )


@api_view(["POST"])
def forgot_password(request):
    # request should be like that
    # {
    #     'username or email' : 'xxxx'
    # }
    data = request.data

    if data.get("username") is None and data.get("email") is None:
        return Response(
            {"error": "no user identity provided"},
            status=status.HTTP_400_BAD_REQUEST,
        )
    lookup = (
        Q(username=data["username"])
        if data.get("username") is not None
        else Q(email=data["email"])
    )
    try:
        user = User.objects.get(lookup)
    except:
        return Response(
            {"error": "no user exists with the provided credentials"},
            status=status.HTTP_400_BAD_REQUEST,
        )
    code = random_verification_code(100000, 999999)
    print(code)
    obj = ResetPasswordVerification.objects.create(user=user, verification_code=code)
    print(user)

    send_mail(
        subject="verification code",
        message=f"this is your verification code {code}",
        from_email=EMAIL_HOST_USER,
        recipient_list=[user.email],
    )
    # code = random_verification_code(100000, 999999)
    # obj.verification_code = code
    # obj.save()

    index = user.email.index("@")

    email = user.email[:2] + "******" + user.email[index - 2 :]

    return Response(
        {
            "success": True,
            "message": f"A verification email has been sent to {email}",
        },
        status=status.HTTP_200_OK,
    )


@api_view(["POST"])
def verify_forgot_password_code(request):
    # request should be like that
    # {
    #     'username or email' : 'xxxx',
    #     'verification_code' : 123456
    # }
    data = request.data

    if data.get("username") is None and data.get("email") is None:
        return Response(
            {"error": "no user identity provided"},
            status=status.HTTP_400_BAD_REQUEST,
        )
    lookup = (
        Q(username=data["username"])
        if data.get("username") is not None
        else Q(email=data["email"])
    )
    try:
        user = User.objects.get(lookup)
    except:
        return Response(
            {"error": "no user exists with the provided credentials"},
            status=status.HTTP_400_BAD_REQUEST,
        )

    verification_code = request.data.get("verification_code")
    if verification_code is None:
        return Response(
            {"error": "you must enter the verification_code"},
            status=status.HTTP_400_BAD_REQUEST,
        )
    obj = user.reset_password_verification
    if verification_code == obj.verification_code:
        obj.delete()
        return Response(
            {"success": True, "message": "now you can reset your password"},
            status=status.HTTP_200_OK,
        )

    return Response(
        {"error": "invalid verification_code"},
        status=status.HTTP_400_BAD_REQUEST,
    )


@api_view(["POST"])
def reset_password(request):
    # request should be like that
    # {
    #     'username or email' : 'xxxx',
    #     'password' :wqewq,
    #     'confirm_password':dwd
    # }
    data = request.data
    if data.get("username") is None and data.get("email") is None:
        return Response(
            {"error": "no user identity provided"},
            status=status.HTTP_400_BAD_REQUEST,
        )
    lookup = (
        Q(username=data["username"])
        if data.get("username") is not None
        else Q(email=data["email"])
    )
    try:
        user = User.objects.get(lookup)
    except:
        return Response(
            {"error": "no user exists with the provided credentials"},
            status=status.HTTP_400_BAD_REQUEST,
        )

    serializer = ResetPasswordSerializer(instance=user, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({"success": True})

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
