from django.urls import path
from .views import (
    register,
    complete_register,
    my_login,
    my_logout,
    send_email_verification_code,
    verify_email,
    forgot_password,
    verify_forgot_password_code,
    reset_password,
    check_username_uniquness
)


urlpatterns = [
    path("register/", register, name="register"),
    path("login/", my_login, name="login"),
    path("logout/", my_logout, name="logout"),
    path("complete_register/", complete_register, name="complete_register"),
    path("send_email_verification_code/", send_email_verification_code, name="send_email_verification_code"),
    path("verify_email/", verify_email, name="verify_email"),
    path("forgot_password/", forgot_password, name="forgot_password"),
    path("verify_forgot_password_code/", verify_forgot_password_code, name="verify_forgot_password_code"),
    path("reset_password/", reset_password, name="reset_password"),
    path("username-uniquness/", check_username_uniquness, name="check_username_uniquness")
]