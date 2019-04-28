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
    
    uname = request.GET.get('username','')
    passw = request.GET.get('password','')

    user = authenticate(request,username=uname,password=passw)

    if user is not None:
        tempUser = User.objects.filter(username=uname).first()
        usertweets = TweetsTable.objects.filter(author=tempUser).all()

        tweetData = []

        for tweets in usertweets:
            tweetData.append(tweets.tweet)

        # print(tweetData)

        return JsonResponse({
            "tweetdata" : tweetData,
            "status" : "OK"
        })
    else:
        return JsonResponse({
            "tweetdata":[],
            "status" : "FAIL"
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

