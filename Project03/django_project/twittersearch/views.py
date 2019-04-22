from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
import tweepy
try:
    import json
except ImportError:
    import simplejson as json

ACCESS_TOKEN = '615758028-5BAQebD7lgx1aJRovnDyWAvDEraLWAQlmCHbRkSC'
ACCESS_SECRET = 'ePXgqc1bkvA2ldN7NOY6ozZBNdH8YL9Oh04Py2W8kaoD2'
CONSUMER_KEY = '36B6HMdNyN2iGGAwEHniaQuiH'
CONSUMER_SECRET = 'KHt8Vg31hjSBeeSibrZ66r0U38z29BaLw2NObNOg0GYdOoJgMZ'

# Create your views here.

def twitresults(request):
    auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
    auth.set_access_token(ACCESS_TOKEN, ACCESS_SECRET)
    
    api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True, compression=True)
    # tweets = tweepy.Cursor(api.search, q='#nlproc', count=3)
    canada_trends = api.trends_place(id = 23424775)
    
    # print(json.dumps(canada_trends, indent=4))

    n = 0
    results = []
    while n != 3:
        query = canada_trends[0]['trends'][n]['name']
        # print(canada_trends[0]['trends'][n]['name'])
    
        for status in tweepy.Cursor(api.search, q=query).items(1):
            print(json.dumps(status._json, indent=4))
            results.append(status._json)
        
        n=n+1

    return JsonResponse({
        "status":"OK",
        "results":results
    })

