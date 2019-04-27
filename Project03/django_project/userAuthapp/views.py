from django.shortcuts import render

from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
import json
# Create your views here.
from .models import UserInfo

def add_user(request):
    
    
    #json_req = json.loads(request.body)
    
    uname = request.GET.get('username','')
    passw = request.GET.get('password','')
    print(uname,passw)

    if uname != '':
        user = User.objects.create_user(username=uname, password=passw)
        login(request,user)
        print(user)
        print("Check the laaaaaaaag")
        return JsonResponse({'status':'LoggedIn'})

    else:
        print("Damnit!")
        return JsonResponse({'status':'LoggedOut'})

def login_user(request):
    
   # json_req = json.loads(request.body)
    uname = request.GET.get('username','')
    passw = request.GET.get('password','')
    print(uname,passw)
    user = authenticate(username=uname,password=passw)
    print(user)
    if user is not None:
        login(request,user)
        print("dope")
        return JsonResponse({
            'status':'LoggedIn'
            })
    else:
        print("cmmann dood")
        return JsonResponse({'status':'LoginFailed'})

def user_info(request):
    
    if not request.user.is_authenticated:
        print("Good")
        return JsonResponse({'status':'LoggedOut'})
    else:
        # do something only a logged in user can do
      #  print("Hello" + str(request.user.first_name))
        print("Waaariq")
        return JsonResponse({'status' : 'Hello' + request.user.first_name})
    

