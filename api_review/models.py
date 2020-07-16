from django.db import models
from api_user.models import User
from api_titles.models import Title
from django.core.validators import MinValueValidator, MaxValueValidator

class Review(models.Model):
    text = models.CharField(max_length=300)
    score = models.IntegerField(null=True, blank=True, validators=[
            MaxValueValidator(10),
            MinValueValidator(1)
        ])
    pub_date = models.DateTimeField("Дата публикации", auto_now_add=True, db_index=True) 
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name="author_review")    
    title =  models.ForeignKey(Title, blank=True, on_delete=models.CASCADE, related_name='title_review')

    def __str__(self): 
       return self.text 

class Comment(models.Model):
    text = models.TextField()
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name="comments")
    pub_date = models.DateTimeField(auto_now_add=True)
    review = models.ForeignKey(Review, on_delete=models.CASCADE, related_name="comments")