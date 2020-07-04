from django.urls import path, include
from rest_framework.authtoken import views
from rest_framework.routers import DefaultRouter
from rest_framework import routers
from .views import UserViewSet, Tok
from rest_framework_simplejwt.views import (TokenObtainPairView,TokenRefreshView,)

router = routers.DefaultRouter()
router.register(r'users', UserViewSet, basename="users")



urlpatterns = [
    path('', include(router.urls)),
    path('token/', Tok.as_view(), name='token_obtain_pair'),
    #path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('auth/email/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    
]
