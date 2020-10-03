from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.db import models


class CustomSuperUser(BaseUserManager):
    
    use_in_migrations = True

    def _create_user(self, email, password, **extra_fields):
        """
        Create and save a user with the given username, email, and password.
        """
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email=None, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', False)
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email=None, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self._create_user(email, password, **extra_fields)


class User(AbstractUser):
    STATUS = [
       ('user', 'user'),
       ('admin', 'admin'),
       ('moderator', 'moderator'),
    ]
    role = models.CharField(max_length=9, choices=STATUS, default='admin')
    bio = models.CharField(max_length=250, blank=True, null=True)
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=250, blank=True, null=True, unique=True)
    confirm_code = models.CharField(max_length=5, default='12345678')
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
    objects = CustomSuperUser()
