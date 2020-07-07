from django.urls import path, include
from rest_framework import routers
from rest_framework.authtoken import views
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import (TokenObtainPairView,TokenRefreshView)
from .views import UserViewSet
from .views import MyTokenObtainPairView, EmailTokenView
#from .views import EmailTokenView, LoginView


router = routers.DefaultRouter()
router.register(r'users', UserViewSet, basename='users')


urlpatterns = [
    path('', include(router.urls)),
    path('users/me/', UserViewSet.as_view({'patch': 'partial_update'})),
    path('token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    #path('token/', LoginView.as_view(), name='LoginView'),
    #path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('auth/email/', EmailTokenView.as_view(), name='conf_code'),
    
    
]
