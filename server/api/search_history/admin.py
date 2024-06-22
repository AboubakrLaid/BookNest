from django.contrib import admin
from .models import SearchHistory

# Register your models here.

class SearchHistoryAdmin(admin.ModelAdmin):
    list_display = ['user', 'query']
    
    
admin.site.register(SearchHistory, SearchHistoryAdmin)
