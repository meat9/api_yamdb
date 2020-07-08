from django.urls import path, include
from rest_framework.routers import DefaultRouter

from .views import CategoryViewSet, TitleViewSet, GenreViewSet

router = DefaultRouter()
router.register('categories', CategoryViewSet)
router.register('genres', GenreViewSet)
router.register('titles', TitleViewSet)


urlpatterns = [
    path('', include(router.urls)),
]