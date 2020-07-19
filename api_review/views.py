from django.shortcuts import render, get_object_or_404
from django.db.models import aggregates, Avg
from rest_framework import request, viewsets 
from rest_framework.exceptions import ValidationError
from rest_framework.pagination import PageNumberPagination
from .models import Review, Comment
from .serializers import ReviewSerializer, CommentSerializer
from api_titles.models import Title
from api_user.permissions import ModeratorOrAuthorPerm, IsOwnerOrReadOnly


class ReviewViewSet(viewsets.ModelViewSet):
    serializer_class = ReviewSerializer
    permission_classes = [ModeratorOrAuthorPerm]
    pagination_class = PageNumberPagination

    def perform_create(self, serializer):
        title = get_object_or_404(Title, id=self.kwargs.get('title_id'))
        if Review.objects.filter(author=self.request.user, title=title).exists():
            raise ValidationError('Оценка уже выставлена')
        serializer.save(author=self.request.user, title=title)
        agg_score = Review.objects.filter(title=title).aggregate(Avg('score'))
        title.rating = agg_score['score__avg']
        title.save(update_fields=['rating'])

    def perform_update(self, serializer):
        serializer.save()
        title = get_object_or_404(Title, id=self.kwargs.get('title_id'))
        agg_score = Review.objects.filter(title=title).aggregate(Avg('score'))
        title.rating = agg_score['score__avg']
        title.save(update_fields=['rating'])

    def get_queryset(self):
        title = get_object_or_404(Title, id=self.kwargs.get('title_id'))
        return Review.objects.filter(title=title)

class CommentViewSet(viewsets.ModelViewSet):
    serializer_class = CommentSerializer
    permission_classes = [ModeratorOrAuthorPerm]
    pagination_class = PageNumberPagination

    def get_queryset(self):
        review = get_object_or_404(Review, pk=self.kwargs.get('review_id'))
        return Comment.objects.filter(review=review)

    def perform_create(self, serializer):
        review = get_object_or_404(Review, pk=self.kwargs.get('review_id'))
        serializer.save(author=self.request.user, review=review)
