from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic import TemplateView
from rest_framework_simplejwt.views import (
        TokenObtainPairView,
        TokenRefreshView,
    )
urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/', include('api_user.urls')),
    path('redoc/', TemplateView.as_view(template_name='redoc.html'), name='redoc'),
]
