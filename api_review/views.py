from django.shortcuts import render

from rest_framework import status
from rest_framework.response import Response 
from django.shortcuts import get_object_or_404 
from rest_framework import permissions, request, viewsets 
from django.db.models import aggregates, Avg
from .models import Review, Comment
from api_titles.models import Title
from .serializers import ReviewSerializer, CommentSerializer
from api_user.permissions import ModeratorOrAuthorPerm, IsOwnerOrReadOnly
from .permissions import CommentPermission
from rest_framework.exceptions import ValidationError
from rest_framework.decorators import api_view
 
class ReviewViewSet(viewsets.ModelViewSet): 
    queryset = Review.objects.all() 
    serializer_class = ReviewSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly, ModeratorOrAuthorPerm]

    def perform_create(self, serializer):
        title = get_object_or_404(Title, pk=self.kwargs.get('title_id'))
        if Review.objects.filter(author=self.request.user, title=title).exists():
            raise ValidationError('Оценка уже выставлена')
        serializer.save(author=self.request.user)

    @api_view(['GET', 'POST']) 
    def api_review(self, request):
        if not self.request.auth:
            return Response(status=status.HTTP_404_FORBIDDEN)
        if request.method == 'GET':
            reviews = Review.objects.all()
            serializer = ReviewSerializer(reviews, many=True)
            return Response(serializer.data)
        elif request.method == 'POST':            
            title = get_object_or_404(Title, pk=self.kwargs.get('title_id'))       
            if self.request.data.score not in range (1, 10):
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            serializer = ReviewSerializer(data=request.data) 
            if serializer.is_valid(): 
                serializer.save(author=self.request.user)
                return Response(serializer.data, status=status.HTTP_201_CREATED) 
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def get_queryset(self):
        title = get_object_or_404(Title, pk=self.kwargs.get('title_id'))
        return Review.objects.filter(title=title)

class CommentViewSet(viewsets.ModelViewSet): 
    queryset = Comment.objects.all() 
    serializer_class = CommentSerializer     
    permission_classes = [ 
        permissions.IsAuthenticated, CommentPermission
    ] 

    def perform_create(self, serializer):
        review = get_object_or_404(Review, pk=self.request.data.get('review_id'))
        serializer.save(author=self.request.user, review=review)

    def get_queryset(self):
        review = get_object_or_404(Review, pk=self.request.data.get('review_id'))
        return Comment.objects.filter(review=review)

# def get_permissions(self):
    #     permission_classes = []
    #     if self.action == 'list':
    #         permission_classes = [permissions.AllowAny]
    #     elif self.action == 'destroy'or self.action == 'create' or self.action == 'retrieve' or self.action == 'update' or self.action == 'partial_update':
    #         permission_classes = [ModeratorOrAuthorPerm]
    #     return [permission() for permission in permission_classes]