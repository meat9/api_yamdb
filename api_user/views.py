
import secrets
from django.core.mail import send_mail
from rest_framework import viewsets, serializers
from rest_framework.decorators import action, api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import User
from .permissions import ModPerm, AdmPerm, UserPerm
from .serializers import UserSerializer


##############################--Возможно лишнее---#####################
from rest_framework.permissions import AllowAny
from django.http import JsonResponse
from django.contrib.auth import authenticate
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.decorators import permission_classes
from django.contrib.auth.hashers import make_password
#######################################################################

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    lookup_field = 'username'
    permission_classes = [AllowAny]#######Перед ревью вернуть######AdmPerm

    @action(detail=False, permission_classes=[AllowAny], methods=['PATCH', 'GET'])########Перед ревью вернуть#######UserPerm
    def me(self, request, *args, **kwargs):
        serializer = UserSerializer(request.user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)





from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView


class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        refresh = self.get_token(self.user)
        data['refresh'] = str(refresh)
        data['access'] = str(refresh.access_token)

        # Add extra responses here
        data['email'] = self.user.email

        return data


class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer




class EmailTokenView(APIView):
    def post(self, request):
        email = request.data.get('email')
        try:
            User.objects.get(email=email)
            return Response("Email адрес занят")
        except User.DoesNotExist:
            confirm_code = secrets.token_hex(5)
            User.objects.create_user(email=email, confirm_code=confirm_code, is_active=True)
            send_mail(
                'Registration',
                'Your confirmation code is ' + str(confirm_code),
                'from@gmail.com',
                [str(email)],
                fail_silently=False,
            )
            return Response("Код подтверждения выслан вам на почту ")

