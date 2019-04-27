from django.urls import path
from . import views

urlpatterns = [
    path('add_user/', views.add_user, name='userAuthapp-add_user'),
    path('login_user/', views.login_user, name='userAuthapp-login_user'),
    path('user_info/', views.user_info, name='userAuthapp-user_info'),
    path('save_tweet/', views.save_tweet, name='userAuthapp-save-tweet'),
    path('delete_tweets/', views.delete_tweets, name='userAuthapp-delete-tweets')
]
