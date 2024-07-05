from rest_framework.response import Response
from rest_framework import generics
from .models import Category
from .serializers import CategorySerializer
from rest_framework.permissions import IsAuthenticated




class CategoriesList(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = None
    permission_classes = [IsAuthenticated]
    
    def list(self, request, *args, **kwargs):
        qs = self.get_queryset()
        serializer = CategorySerializer(qs, many=True)
        data = serializer.data
        return Response({'categories': data})