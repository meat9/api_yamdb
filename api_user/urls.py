from django.urls import path, include
from rest_framework import routers
from rest_framework.authtoken import views
from rest_framework.routers import DefaultRouter
from .views import UserViewSet, Get_token, EmailCode


router = routers.DefaultRouter()
router.register(r'users', UserViewSet, basename='users')


urlpatterns = [
    path('', include(router.urls)),
    path('users/me/', UserViewSet.as_view({'patch': 'partial_update'})),
    path('auth/token/', Get_token.as_view(), name='token_obtain_pair'),
    path('auth/email/', EmailCode.as_view(), name='conf_code'),
]
