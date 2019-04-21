from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
# Create your views here.

def twitresults(request):
    print(request)
    return JsonResponse({"status":"OK"})

def index(request):
    return render(request, 'index.html')

def indexjs(request):
    return render(request, 'index.js')

def stylecss(request):
    return render(request, 'style.css')


