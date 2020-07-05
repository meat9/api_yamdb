
from django.core.mail import send_mail
from rest_framework import viewsets, serializers
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import User
from .permissions import ModPerm, AdmPerm, UserPerm
from .serializers import UserSerializer
from rest_framework.permissions import AllowAny

import secrets
from rest_framework.decorators import api_view, permission_classes

from django.http import JsonResponse
from django.contrib.auth import authenticate
from rest_framework.views import APIView
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView




class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    #lookup_field = 'username'
    permission_classes = [AllowAny]#############AdmPerm

    @action(detail=False, permission_classes=[AllowAny], methods=['PATCH', 'GET'])###############UserPerm
    def me(self, request, *args, **kwargs):
        serializer = UserSerializer(request.user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)






def sendmail(request):
    confirm_code = secrets.token_hex(5)
    send_mail(
        'Registration',
        'Your confirmation code is ' + str(confirm_code),
        'from@example.com',
        [request.user.email],
        fail_silently=False,
    )



class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        refresh = self.get_token(self.user)
        data['refresh'] = str(refresh)
        data['access'] = str(refresh.access_token)

        # Add extra responses here
        #data['username'] = self.user.username
        data['email'] = self.user.email
        #data['groups'] = self.user.groups.values_list('name', flat=True)
        return data


class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer



    
    #return HttpResponse('Mail successfully sent')

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



