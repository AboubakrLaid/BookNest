from django.db import models
from django.db.models import Q
from django.db.models.query import QuerySet


class CategoryQuerySet(models.QuerySet):
    def search(self, query):
        # self is like Category.objects
        # query is name of the category
        qs = self.filter(name__istartswith = query)
        return qs


class CategoryManager(models.Manager):
    def get_queryset(self) -> QuerySet:
        return CategoryQuerySet(self.model , self._db)

    def search(self, query):
        #-------------------------------<|> this search is from CategoryQuerySet
        return self.get_queryset().search(query)


class Category(models.Model):
    name = models.CharField(max_length=20)
    
    objects = CategoryManager()
    
    