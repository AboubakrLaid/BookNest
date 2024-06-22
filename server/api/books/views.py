from rest_framework import generics
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from rest_framework.pagination import PageNumberPagination
from .models import (
    Book, 
)
from .serializers import (
    BookSerializer,
    
)


class BooksList(generics.ListAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    pagination_class = PageNumberPagination
    
@api_view(['GET'])
def books_list(request):
    try:
        qs = Book.objects.all()
        serializer = BookSerializer(qs, many = True)
        data = serializer.data
        return Response(data, status=status.HTTP_200_OK)
    except:
        return Response({'message' : 'something went wrong'}, status= status.HTTP_500_INTERNAL_SERVER_ERROR)
    

    
        
    

