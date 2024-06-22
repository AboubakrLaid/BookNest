from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import (
    api_view,
    permission_classes,
    authentication_classes,
)
from rest_framework.permissions import IsAuthenticated
from accounts.authentication import BearerTokenAuthentication
from .serializers import CommentSerializer, UpdateCommentSerializer
from books.models import Book
from .models import Comment


@api_view(["POST"])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def add_comment(request):
    data = request.data

    # book_obj = get_object_or_404(Book, pk=data['book'])
    # data['book'] = book_obj.id

    try:
        book_obj = Book.objects.get(id=data["book"])
        data["book"] = book_obj.id

    except Book.DoesNotExist:
        return Response(
            {"error": f'no book exist with id {data["book"]}'},
            status=status.HTTP_400_BAD_REQUEST,
        )

    serializer = CommentSerializer(data=data)
    if serializer.is_valid():
        serializer.save(owner=request.user)
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def get_book_comments(request, id):
    user = request.user
    try:
        book = Book.objects.get(id=id)
        comments = book.comments.exclude(reporters = user)
        # comments = [comment for comment in book.comments if user in comment.repoters]
        data = CommentSerializer(comments, many=True).data
        return Response(data)
    except Book.DoesNotExist:
        return Response(
            {"error": f"no book exist with id {id}"}, status=status.HTTP_400_BAD_REQUEST
        )


@api_view(["PATCH"])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def update_comment(request):
    data = request.data
    # comment = get_object_or_404(Comment, id=data['id'], owner=request.user)
    if data.get("id") is None:
        return Response(
            {"error": "expect field id"}, status=status.HTTP_400_BAD_REQUEST
        )
    if data.get("content") is None:
        return Response(
            {"error": "expect field content"}, status=status.HTTP_400_BAD_REQUEST
        )

    try:
        comment = Comment.objects.get(id=data["id"], owner=request.user)
    except Comment.DoesNotExist:
        return Response(
            {
                "error": "comment id is not valid or the current user is not the owner of the comment"
            },
            status=status.HTTP_400_BAD_REQUEST,
        )

    serializer = UpdateCommentSerializer(instance=comment, data=data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def react_to_comment(request, id):
    user = request.user

    try:
        comment = Comment.objects.get(id=id)
    except Comment.DoesNotExist:
        return Response(
            {"error": "comment id is not valid"}, status=status.HTTP_400_BAD_REQUEST
        )
    if user in comment.likers.all():
        comment.likers.remove(user)
        liked = False
    else:
        comment.likers.add(user)
        liked = True

    return Response({"liked": liked}, status=status.HTTP_200_OK)



@api_view(["POST"])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def report_comment(request, id):
    user = request.user

    try:
        comment = Comment.objects.get(id=id)
    except Comment.DoesNotExist:
        return Response(
            {"error": "comment id is not valid"}, status=status.HTTP_400_BAD_REQUEST
        )
    
    comment.reporters.add(user)
    if comment.reporters.all().count() == 2:
        comment.delete()

    return Response({"reported": True}, status=status.HTTP_200_OK)
