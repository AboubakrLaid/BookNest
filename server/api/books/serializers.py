from rest_framework import serializers
from .models import (
    Book, 
)
from categories.serializers import CategorySerializer


        
class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = '__all__'
    # categories = CategorySerializer(many = True, read_only=True)
    
    # display only the name of the categories
    categories = serializers.SlugRelatedField(
        many=True,
        read_only=True,
        slug_field='name'
    )