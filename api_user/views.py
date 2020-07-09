
import secrets
from django.core.mail import send_mail
from rest_framework import viewsets, serializers
from rest_framework.decorators import action, api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from .models import User
from .permissions import ModPerm, AdmPerm, UserPerm
from .serializers import UserSerializer


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    lookup_field = 'username'
    permission_classes = [AdmPerm]

    @action(detail=False, permission_classes=[UserPerm], methods=['PATCH', 'GET'])
    def me(self, request, *args, **kwargs):
        serializer = UserSerializer(request.user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)


class EmailCode(APIView):
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


class Get_token(APIView):
    def post(self, request):
        email = request.data.get('email')
        confirm_code = request.data.get('confirm_code')
        try:
            user = User.objects.get(email=email, confirm_code=confirm_code)
            def get_tokens_for_user(user):
                refresh = RefreshToken.for_user(user)
                token = str(refresh.access_token)
                return token
            return Response (("Ваш токен: " + get_tokens_for_user(user)))

        except User.DoesNotExist:
            return Response("Пользователь не найден или код водтверждения не верный")
