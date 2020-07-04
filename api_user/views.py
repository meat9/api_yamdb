from django.shortcuts import get_object_or_404
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, serializers, generics, filters
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from .models import User
from .permissions import Admin_auth, User_auth, Moderator_auth
from rest_framework.views import APIView
from django.http import JsonResponse
from django.contrib.auth import authenticate
from .serializers import UserSerializer
from rest_framework.response import Response
from rest_framework import status


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    lookup_field = "username"

    def get_permissions(self):
        if self.request.method == 'GET':
            self.permission_classes = [Admin_auth]
       # elif self.request.method == 'HEAD':
        #    self.permission_classes = [Admin_auth]
        elif self.request.method == 'POST':
            self.permission_classes = [Admin_auth]
        elif self.request.method == 'PUT':
            self.permission_classes = [Admin_auth]
        elif self.request.method == 'PATCH':
            self.permission_classes = [Admin_auth]
        elif self.request.method == 'DELETE':
            self.permission_classes = [Admin_auth]
        #elif self.request.method == 'OPTIONS':
        #    self.permission_classes = [Admin_auth]
        return super(self.__class__, self).get_permissions()

class UserViewSetMe(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    lookup_field = "username"


    def get_object(self):
    
        if self.kwargs.get('username', None) == 'me':
            self.kwargs['username'] = self.request.user.username
        return User.objects.get(username=self.kwargs['username'])
    #def get_permissions(self):




#class Tok(TokenObtainPairView):
 #   serializer_class = TokSerializer


#class Tok(APIView):
    #permission_classes = (AllowAny,)

    #def post(self, request, *args, **kwargs):
        #username = request.data['username']
        #password = request.data['password']
       # email = request.data['email']

        #user = authenticate(username=username, password=password)
        #user = authenticate(email=email)
       #token = jwt.encode(payload, SECRET_KEY).decode('utf-8')
        #return JsonResponse({'success': 'true', 'token': token, 'user': user})
        #if user is not None:
         #   payload = {
          #      'user_id': user.id,
           #     'exp': datetime.now(),
            #    'token_type': 'access'
            #}

           # user = {
           #     'user': username,
           #     'email': user.email,
           #     'time': datetime.now().time(),
           #     'userType': 10
           # }

            #token = jwt.encode(payload, SECRET_KEY).decode('utf-8')
            #return JsonResponse({'success': 'true', 'token': token, 'user': user})

        #else:
           # return JsonResponse({'success': 'false', 'msg': 'The credentials provided are invalid.'})



