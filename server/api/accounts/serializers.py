from dataclasses import field
from os import write
from .models import User
from . import validators
from rest_framework import serializers
from rest_framework.serializers import BaseSerializer
from .serializers import User
from categories.models import Category
from custome_serilizer.serializers import CustomErrorSerializerMixin
# from custome_serilizer.serializers import CustomSerializer


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id','username']




    
class CreateUserSerializer(CustomErrorSerializerMixin, serializers.ModelSerializer):
    username = serializers.CharField(validators=validators.unique_username)
    email = serializers.CharField(validators=validators.unique_email)

    class Meta:
        model = User
        fields = ["username", "email", "password"]
        extra_kwargs = {
            # ! can not specify extra kwargs for confirm password here cuz
            # ! it's not a model field
            "password": {"write_only": True}, # means only to use in post put (send)
            # "confirm_password": {"write_only": True}
        }
    def to_representation(self, serializer):
        return super().to_representation(serializer)
        

        
        
    

    

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data["username"],
            email=validated_data["email"],
        )
        user.set_password(validated_data["password"])
        user.save()
        return user


class CompleteUserProfileSerializer(CustomErrorSerializerMixin,serializers.ModelSerializer):
    first_name = serializers.CharField(required=True)
    last_name = serializers.CharField(required=True)
    class Meta:
        model = User
        fields = ["first_name", "last_name", "favorite_categories", "profile_image"]
        validators = [validators.unique_firstname_lastname_together]
        
    def update(self, instance, validated_data):
        instance.first_name = validated_data.get('first_name')
        instance.last_name = validated_data.get('last_name')
        instance.favorite_categories.set(validated_data['favorite_categories'])
        instance.profile_image = validated_data.get('profile_image')
        print(instance.favorite_categories)
        
        # categories = Category.objects.all(id__in = )
        instance.save()
        
        return instance
    
    
class ResetPasswordSerializer(serializers.ModelSerializer):
    confirm_password = serializers.CharField(write_only=True)
    
    class Meta:
        model=User
        fields= ['password','confirm_password']
        extra_kwargs={
            'password':{'write_only':True}
        }
        
    def validate(self, attrs):
        if attrs['password'] != attrs['confirm_password']:
            raise serializers.ValidationError({'confirm_password' : 'Make sure is the same as password.'})
        attrs.pop('confirm_password')
        return attrs
    
    def update(self, instance, validated_data):
        instance.set_password(validated_data['password'])
        instance.save()
        
        return instance