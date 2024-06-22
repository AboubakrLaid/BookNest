from rest_framework import generics
from .models import Category
from .serializers import CategorySerializer
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import IsAuthenticated




class CategoriesList(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = None
    permission_classes = [IsAuthenticated]    