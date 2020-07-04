from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    
    STATUS = [
       ('user', 'user'),
       ('admin', 'admin'),
       ('moderator', 'moderator'),
    ]
    role = models.CharField(max_length=9, choices=STATUS, default=STATUS[0][0])
    bio = models.CharField(max_length=250, blank=True, null=True)
    email = models.EmailField(unique=True)