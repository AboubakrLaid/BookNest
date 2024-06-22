from django.db import models
from django.db.models import Q
from django.db.models.query import QuerySet
from categories.models import Category
from datetime import datetime


class BookQuerySet(models.QuerySet):
    def search_by_categories(self, query: list[str]):
        # searched_categories : list[str] = []
        qs = self.all()
        for category_name in query:
            # category = Category.objects.get(name__iexact = category_name)
            # qs = qs.filter(categories = category)       
            
            qs = qs.filter(categories__name__iexact = category_name)      
            
        
        return qs
    
    def search_by_title_author(self, title, author):
        lookup = Q()
        title_lookup = Q()
        author_lookup = Q()
        
        if title is not None:
            title_lookup = Q(title__istartswith = title)
        if author is not None:
            author_lookup = Q(author__istartswith = author)
            
        lookup = title_lookup & author_lookup
        qs = self.filter(lookup)
        return qs
    
    def search_by_language(self, language):
        qs = self.filter(language__istartswith = language)
        return qs
    
    def search_by_date(self, start_date, end_date, descending):
        if start_date is None:
            start_date = datetime(1800, 1,1)
            
        if end_date is None:
            end_date = datetime.now()
        
        order = 'publish_date'
        if descending is not None:
            order = '-'+ order
            
        qs = self.filter(publish_date__range = (start_date, end_date)).order_by(order)
        return qs
    
    def search_by_rating(self, rating):
        qs = self.filter(rating__gte = rating)
        return qs
            
        
    
    


class BookManager(models.Manager):
    def get_queryset(self) -> QuerySet:
        return BookQuerySet(self.model, self._db)
    
    def search_by_categories(self, query: list[str]):
        return self.get_queryset().search_by_categories(query)
    
    def search_by_title_author(self, title, author):
        return self.get_queryset().search_by_title_author(title, author)
    
    def search_by_language(self, language):
        return self.get_queryset().search_by_language(language)
    
    def search_by_date(self, start_date, end_date ,descending):
        return self.get_queryset().search_by_date(start_date,end_date, descending)
    
    def search_by_rating(self, rating):
        return self.get_queryset().search_by_rating(rating)
    


class Book(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=150)
    rating = models.DecimalField(max_digits=3, decimal_places=2, blank=True, null=True)
    description = models.CharField(max_length=300, blank = True, null=True)
    language = models.CharField(max_length=15, blank = True, null=True)
    categories = models.ManyToManyField(Category, related_name= 'books')
    pages = models.IntegerField(blank=True, null=True)
    publisher = models.CharField(max_length=50, blank=True, null=True)
    publish_date = models.DateField(null = True)
    ratings_number = models.IntegerField(blank=True,null=True)
    cover_image = models.CharField(max_length = 200,blank=True,null=True)
    price = models.DecimalField(max_digits=5, decimal_places=2, blank=True,null=True)
    
    objects = BookManager()
    
    
    
    
    