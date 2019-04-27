from django.db import models
from django.contrib.auth.models import User
# Create your models here.
class UserInfoManager(models.Manager):
    def create_user_info(self, username, password, info):
        user = User.objects.create_user(username=username, password=password)
        userinfo = self.create(user=user,info=info)

        return userinfo

class UserInfo(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE, primary_key=True)
    info = models.CharField(max_length=30)
    objects = UserInfoManager()

class TweetsTable(models.Model):
    tweetid = models.BigIntegerField(primary_key=True)
    tweet = models.TextField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.tweet
    
