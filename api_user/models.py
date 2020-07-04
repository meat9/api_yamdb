from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    
    user = 'user'
    admin = 'admin'
    moderator = 'moderator'
    status = [
       (user, 'user'),
       (admin, 'admin'),
       (moderator, 'moderator'),
    ]
    role = models.CharField(max_length=9, choices=status, default=status[0][0])
    bio = models.CharField(max_length=250, blank=True, null=True)
    email = models.EmailField(unique=True)