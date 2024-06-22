from django.db import models
from accounts.models import User


class SearchHistory(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='serach_history')
    query = models.CharField(max_length=200)
    