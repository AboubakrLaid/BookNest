from django.urls import path
from .views import (
    BooksList,
    books_list
)

urlpatterns = [
    path('', BooksList.as_view(), name='books_list'),
    path('v2/', books_list, name='books_list'),
]