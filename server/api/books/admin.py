from django.contrib import admin
from .models import (
    Book,
)


    
class BookAdmin(admin.ModelAdmin):
    list_display = ['id', 'title','rating']
    

admin.site.register(Book, BookAdmin)
