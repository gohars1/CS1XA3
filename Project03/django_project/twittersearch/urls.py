from django.urls import path
from . import views

urlpatterns = [
  #  path('', views.index, name='twittersearch-index'),
  #  path('index.js/', views.indexjs, name='twittersearch-index'),
  #  path('style.css/', views.stylecss, name='twittersearch-style'),
    path('twitresults/', views.twitresults , name='twittersearch-twitresults'),
    
]
