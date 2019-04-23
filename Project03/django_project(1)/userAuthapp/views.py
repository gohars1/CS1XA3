from django.shortcuts import render

from django.http import HttpResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
import json
# Create your views here.
from .models import UserInfo

def add_user(request):
    
    
    #json_req = json.loads(request.body)
    
    uname = request.GET.get('username','')
    passw = request.GET.get('password','')
    print(uname, passw)

    if uname != '':
        user = User.objects.create_user(username=uname, password=passw)

        login(request,user)
        return HttpResponse('LoggedIn')

    else:
        return HttpResponse('LoggedOut')

def login_user(request):
    
    json_req = json.loads(request.body)
    uname = json_req.get('username','')
    passw = json_req.get('password','')

    user = authenticate(request,username=uname,password=passw)
    if user is not None:
        login(request,user)
        return HttpResponse("LoggedIn")
    else:
        return HttpResponse('LoginFailed')

def user_info(request):
    
    if not request.user.is_authenticated:
        return HttpResponse("LoggedOut")
    else:
        # do something only a logged in user can do
        return HttpResponse("Hello " + request.user.first_name)
    

