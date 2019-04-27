from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
import tweepy
try:
    import json
except ImportError:
    import simplejson as json
#These tokens allow for usage of the Twitter API
ACCESS_TOKEN = '615758028-5BAQebD7lgx1aJRovnDyWAvDEraLWAQlmCHbRkSC'
ACCESS_SECRET = 'ePXgqc1bkvA2ldN7NOY6ozZBNdH8YL9Oh04Py2W8kaoD2'
CONSUMER_KEY = '36B6HMdNyN2iGGAwEHniaQuiH'
CONSUMER_SECRET = 'KHt8Vg31hjSBeeSibrZ66r0U38z29BaLw2NObNOg0GYdOoJgMZ'

# Create your views here.

# Accesses twitter API and returns a JSON of the trending tweets depending on country 
def twitresults(request):
    
    
    country_code = request.GET.get('country', '')

    auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
    auth.set_access_token(ACCESS_TOKEN, ACCESS_SECRET)
    
    api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True, compression=True)
    
    canada_trends = api.trends_place(id = int(country_code))
    
    

    n = 0
    results = []
    while n != 3:
        query = canada_trends[0]['trends'][n]['name']
        
    
        for status in tweepy.Cursor(api.search, q=query).items(1):
            
            results.append(status._json)
        
        n=n+1

    return JsonResponse({
        "status":"OK",
        "results":results
    })

