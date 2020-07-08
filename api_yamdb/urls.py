from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic import TemplateView
from rest_framework_simplejwt.views import (
        TokenObtainPairView,
        TokenRefreshView,
    )

from api_.views import CategoryViewSet, TitleViewSet, GenreViewSet

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/', include('api_user.urls')),
    path('api/v2/', include('api_titles.urls')),
    path('redoc/', TemplateView.as_view(template_name='redoc.html'), name='redoc'),
]
