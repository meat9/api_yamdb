from django.shortcuts import render

from rest_framework import status
from rest_framework.response import Response 
from django.shortcuts import get_object_or_404 
from rest_framework import viewsets, permissions 
 
from api_review.models import Review, Comment
from api_titles.models import Title
from .serializers import ReviewSerializer, CommentSerializer
from api_user.permissions import ModeratorOrAuthorPerm, IsOwnerOrReadOnly
from .permissions import CommentPermission
 
class ReviewViewSet(viewsets.ModelViewSet): 
    queryset = Review.objects.all() 
    serializer_class = ReviewSerializer
    
    def get_permissions(self):
        permission_classes = []
        if self.action == 'create':
            permission_classes = [ModeratorOrAuthorPerm]
        elif self.action == 'list':
            permission_classes = [permissions.AllowAny]
        elif self.action == 'retrieve' or self.action == 'update' or self.action == 'partial_update':
            permission_classes = [ModeratorOrAuthorPerm]
        elif self.action == 'destroy':
            permission_classes = [ModeratorOrAuthorPerm]
        return [permission() for permission in permission_classes]

        def perform_create(self, serializer):
            title = get_object_or_404(Title, pk=self.kwargs.get('title_id'))
            serializer.save(author=self.request.user, title=title)

        def get_queryset(self):
            title = get_object_or_404(Title, pk=self.kwargs['title_id'])
            return Review.objects.filter(title=title)

class CommentViewSet(viewsets.ModelViewSet): 
    queryset = Comment.objects.all() 
    serializer_class = CommentSerializer     
    permission_classes = [ 
        permissions.IsAuthenticated, CommentPermission
    ] 

    def perform_create(self, serializer):
        review = get_object_or_404(Review, pk=self.request.data.get('title_id'))
        serializer.save(author=self.request.user, review=review)

    def get_queryset(self):
        review = get_object_or_404(Review, pk=self.request.data.get('title_id'))
        return Comment.objects.filter(review=review)