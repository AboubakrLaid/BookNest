from rest_framework import serializers
from .models import Category


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        fields = ['name']
        model = Category
        
class SearchCategorySerializer(serializers.Serializer):
    count = serializers.IntegerField(read_only=True)
    result = CategorySerializer(many=True, read_only=True)

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        # Assuming `instance` is a queryset of matching categories
        qs = instance  # Or apply your filter here
        print(qs)
        representation['count'] = qs.count()

        # this would be like [{'name' : 's'}, {'name': 'ss'}]
        # representation['result'] = CategorySerializer(qs, many=True).data
        
        # this would be like ['s','ss']
        representation['result'] = [obj.name for obj in qs]
        return representation
   
        
    