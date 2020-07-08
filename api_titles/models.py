from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from api_yamdb.models import User


class Category(models.Model):
    name = models.CharField(max_length=300)
    slug = models.SlugField(unique=True)


class Genre(models.Model):
    name = models.CharField(max_length=300)
    slug = models.SlugField(unique=True)


class Title(models.Model):
    name = models.CharField(max_length=300)
    year = models.IntegerField(null=True, blank=True)
    description = models.CharField(max_length=1000, blank=True)
    rating = models.IntegerField(blank=True, null=True)
    genre = models.ManyToManyField(Genre, verbose_name='Жанр')
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, blank=True, null=True, verbose_name='Категория')


class Review(models.Model):
    text = models.TextField(max_length=3000)
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='reviews')
    score = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(10)])
    pub_date = models.DateTimeField(auto_now_add=True)
    title = models.ForeignKey(Title, on_delete=models.CASCADE, related_name='reviews')


class Comment(models.Model):
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='comments')
    review = models.ForeignKey(Review, on_delete=models.CASCADE, related_name='comments')
    text = models.TextField()
    pub_date = models.DateTimeField(auto_now_add=True, db_index=True)
    