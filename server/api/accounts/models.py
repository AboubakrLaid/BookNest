from django.contrib.auth.models import AbstractUser
from categories.models import Category
from django.db import models


class User(AbstractUser):
    favorite_categories = models.ManyToManyField(Category, related_name="users")
    profile_image = models.ImageField(upload_to='', null=True, blank=True)
    


class EmailVerification(models.Model):
    # user can't access any instance from this model
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='email_verification')
    # is_email_verified = models.BooleanField(default=False)
    verification_code = models.CharField(max_length=6, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"Email verification for {self.user}"
    

class ResetPasswordVerification(models.Model):
    # user can't access any instance from this model
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='reset_password_verification')
    # is_email_verified = models.BooleanField(default=False)
    verification_code = models.CharField(max_length=6, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    
