from django.shortcuts import get_object_or_404
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, serializers, generics, filters
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, IsAdminUser, AllowAny
from .models import User
from .permissions import Admin_auth, User_auth, Moderator_auth
from rest_framework.views import APIView
from django.http import JsonResponse
from django.contrib.auth import authenticate
from .serializers import UserSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import action

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    lookup_field = "username"
    permission_classes = [Admin_auth]
    @action(detail=False, permission_classes=[IsAuthenticated], methods=['PATCH', 'GET'])
    def me(self, request, *args, **kwargs):
        #serializer = self.get_serializer(self.request.user)
        serializer = UserSerializer(request.user, data=request.data, partial=True)
        if serializer.is_valid():
            time_entry = serializer.save()

        return Response(serializer.data)




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



