from django.urls import path, include
from rest_framework import routers
from .views import UserViewSet, Get_token, EmailCode
from api_titles.views import CategoryViewSet, GenreViewSet, TitleViewSet


router = routers.DefaultRouter()
router.register(r'users', UserViewSet, basename='users')
router.register(r'categories', CategoryViewSet)
router.register(r'genres', GenreViewSet)
router.register(r'titles', TitleViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('users/me/', UserViewSet.as_view({'patch': 'partial_update'})),
    path('auth/token/', Get_token.as_view(), name='token_obtain_pair'),
    path('auth/email/', EmailCode.as_view(), name='conf_code'),
]
