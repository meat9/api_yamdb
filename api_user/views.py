from django.shortcuts import get_object_or_404
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, serializers, generics, filters
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from .models import User
#from .permissions import UserPermission
#from .permissions import IsOwnerOrReadOnly
from rest_framework.views import APIView
from django.http import JsonResponse
from django.contrib.auth import authenticate
from .serializers import UserSerializer



class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    lookup_field = "username"

    def get_permissions(self):
        permission_classes = []
        if self.action == 'create':
            permission_classes = [AllowAny]
        elif self.action == 'retrieve' or self.action == 'update' or self.action == 'partial_update':
            permission_classes = [IsAuthenticated]
        elif self.action == 'list' or self.action == 'destroy':
            permission_classes = [IsAdminUser]
        return [permission() for permission in permission_classes]

    def get_object(self):
        
        if self.kwargs.get('username', None) == 'me':
            self.kwargs['username'] = self.request.user.username

        return super(UserViewSet, self).get_object()



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



