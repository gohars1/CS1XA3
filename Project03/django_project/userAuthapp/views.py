from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from .models import UserInfo, TweetsTable
import json

def add_user(request):
    
    uname = request.GET.get('username','')
    passw = request.GET.get('password','')
    print(uname, passw)

    if uname != '':
        user = User.objects.create_user(username=uname, password=passw)

        login(request,user)
        return JsonResponse({
            "status":"OK"
        })

    else:
        return JsonResponse({
            "status":"FAIL"
        })

def login_user(request):
    
    uname = request.GET.get('username','')
    passw = request.GET.get('password','')

    user = authenticate(request,username=uname,password=passw)

    if user is not None:
        login(request,user)
        return JsonResponse({
            "status":"OK"
        })
    else:
        return JsonResponse({
            "status":"FAIL"
        })

def user_info(request):
    
    if not request.user.is_authenticated:
        return JsonResponse({
            "status":"OK"
        })
    else:
        # do something only a logged in user can do
        return JsonResponse({
            "status":"OK",
            "message":"Hello " + request.user.first_name
        })
    
def save_tweet(request):
    
    tweetString = request.GET.get('tweetJSON', '')
    tweet = json.loads(tweetString)
    tweetHtml = request.GET.get('tweetHTML', '')
    uname = request.GET.get('username', '')
    
    returnStatusJson = {
        "status":"OK"
    }

    tweetToSave = TweetsTable(tweetid=tweet['id'], tweet=tweetHtml, author=User.objects.filter(username=uname).first())    
    tweetToSave.save()
    # print(tweetToSave)

    return JsonResponse(returnStatusJson)

# stub - doesn't really do anything yet
# use this to delete user data from table
def delete_tweets(request):
    uname = request.GET.get('username', '')
    returnStatusJson = {
        "status":"OK"
    }

    return JsonResponse(returnStatusJson)

# stub - doesnt doe anything
# this one is not added to the urls, add this one
def get_user_tweets(request):
    
    return JsonResponse({"null":"nothing"})
