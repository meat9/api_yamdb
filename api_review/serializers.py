from rest_framework import serializers
from .models import Review, Comment
  

class ReviewSerializer(serializers.ModelSerializer): 
    author = serializers.ReadOnlyField(source='author.username')
    
    class Meta: 
        model = Review 
        fields = ['id', 'author', 'pub_date', 'score', 'text'] 


class CommentSerializer(serializers.ModelSerializer): 
    author = serializers.ReadOnlyField(source='author.username')
    
    class Meta:         
        model = Comment 
        fields = ['id', 'author', 'pub_date', 'text']
