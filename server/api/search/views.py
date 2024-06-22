from rest_framework.exceptions import ValidationError
from rest_framework import generics
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from categories.models import Category
from categories.serializers import CategorySerializer, SearchCategorySerializer
from books.models import Book
from books.serializers import BookSerializer
from datetime import datetime


class SearchCategory(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = None

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset(*args, **kwargs)
        request = self.request
        starts_with = request.query_params.get('starts_with')
        result = Category.objects.none()
        if starts_with is not None:
            result = qs.search(query=starts_with)

        return result


@api_view(['GET'])
def search_category(request):
    starts_with = request.query_params['starts_with']
    result = Category.objects.none()

    if starts_with is not None:
        result = Category.objects.search(query=starts_with)
        serializer = SearchCategorySerializer(result)
        return Response(serializer.data, status=status.HTTP_200_OK)

    return Response({'message': 'you have to specify what the category name starts with'}, status=status.HTTP_400_BAD_REQUEST)


def is_valid_date_format(date: str):
    expected_format = '%Y-%m-%d'
    try:
        return datetime.strptime(date, expected_format)
    except:
        raise ValidationError({'message': 'expect this format 2024-01-31'})


class SearchBook(generics.ListAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset(*args, **kwargs)
        request = self.request
        string_categories = request.query_params.get('categories')
        result = Book.objects.none()

        if string_categories is not None:
            categories = list(string_categories.split(','))
            result = qs.search_by_categories(categories)
            if not result.exists():
                raise ValidationError({'message': 'Category/ies not found'})
            return result

        title = request.query_params.get('title')
        author = request.query_params.get('author')
        if title or author:
            result = qs.search_by_title_author(title, author)
            return result

        language = request.query_params.get('language')
        if language is not None:
            result = qs.search_by_language(language)
            return result

        start_date = request.query_params.get('start_date')
        end_date = request.query_params.get('end_date')
        descending = request.query_params.get('descending')
        if descending is not None:
            descending = True

        if start_date is not None or end_date is not None:
            if start_date is not None:
                is_valid_date_format(start_date)
            if end_date is not None:
                is_valid_date_format(end_date)
            result = qs.search_by_date(start_date, end_date, descending)
            return result

        rating = request.query_params.get('rating')
        if rating is not None:
            try:
                val = float(rating)
                print(val)
                if val < 0.0 or val > 5.0:
                    raise ValidationError(
                        {'message': 'rating must be beween 0.0 and 5.0'})
                else:
                    result = qs.search_by_rating(rating)
                    return result

            except ValueError:
                raise ValidationError({'error': f'{rating} is not a number'})

        raise ValidationError(
            {'message': "you must provide either 'categories' or ('title' or/and 'author') or language or date or rating "})
