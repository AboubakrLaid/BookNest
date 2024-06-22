from rest_framework import serializers
from .models import Comment
from accounts.serializers import UserSerializer
from custome_serilizer.serializers import CustomErrorSerializerMixin




class CommentSerializer(CustomErrorSerializerMixin,serializers.ModelSerializer):
    owner = UserSerializer(many=False, read_only=True)
    class Meta:
        model = Comment
        fields = '__all__'
        # extra_kwargs = {
        #     'owner' : {'read_only' : True}
        # }
    likes_count = serializers.SerializerMethodField()
    likers = UserSerializer(many=True, read_only=True)
    
    def get_likes_count(self, obj):
        # print(self)
        return obj.likes_count
    

class UpdateCommentSerializer(CustomErrorSerializerMixin,serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ['id', 'content']
    