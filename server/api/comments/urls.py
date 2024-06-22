from django.urls import path
from .views import (
    add_comment,
    get_book_comments,
    update_comment,
    react_to_comment,
    report_comment
)


urlpatterns = [
    path("add_comment/", add_comment, name="add_comment"),
    path('book/<int:id>/', get_book_comments, name='get_book_comments'),
    path('update/', update_comment, name='update_comment'),
    path('react/<int:id>/', react_to_comment, name='like_comment'),
    path('reporte/<int:id>/', report_comment, name='like_comment')
]