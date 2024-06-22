from django.urls import path
from .views import set_search_history


urlpatterns = [
    path("search-history/", set_search_history, name="set_search_history"),
]
