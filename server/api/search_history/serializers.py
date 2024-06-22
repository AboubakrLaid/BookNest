from rest_framework import serializers
from .models import SearchHistory
from custome_serilizer.serializers import CustomErrorSerializerMixin



class SearchHistorySerializer(CustomErrorSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model= SearchHistory
        fields = '__all__'
        
    # def update 