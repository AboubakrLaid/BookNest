from django.db import models
from books.models import Book
from accounts.models import User


class Comment(models.Model):
    owner = models.ForeignKey(User, on_delete=models.CASCADE, related_name="comments")
    book = models.ForeignKey(Book, on_delete=models.CASCADE, related_name="comments")
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    likers = models.ManyToManyField(User, related_name="liked_comments", default=list)
    reporters = models.ManyToManyField(User, related_name='reporters', default=list)
    
    @property
    def likes_count(self):
        return self.likers.count()
