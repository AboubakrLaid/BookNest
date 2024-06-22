from django.urls import path
from .views import (
    SearchCategory,
    search_category,
    SearchBook
)

urlpatterns = [
    path('category/', search_category, name='search_category' ),
    path('category/v2/', SearchCategory.as_view()),
    path('book/', SearchBook.as_view(), name='search_book_by_categories')
]