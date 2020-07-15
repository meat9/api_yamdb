from rest_framework import serializers
from .models import Review, Comment
 
# Serializers define the API representation. 
class ReviewSerializer(serializers.ModelSerializer): 
    author = serializers.SlugRelatedField( 
        read_only=True, 
        slug_field='username' 
     ) 
    class Meta: 
        model = Review 
        fields = ['text', 'author', 'pub_date', 'score', 'id'] 

class CommentSerializer(serializers.ModelSerializer): 
    author = serializers.SlugRelatedField( 
        read_only=True, 
        slug_field='username' 
     ) 
    class Meta:         
        model = Comment 
        fields = ['id', 'author', 'pub_date', 'review_id']

