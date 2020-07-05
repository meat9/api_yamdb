
from rest_framework import viewsets, serializers
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import User
from .permissions import ModPerm, AdmPerm, UserPerm
from .serializers import UserSerializer


from django.http import JsonResponse
from django.contrib.auth import authenticate
from rest_framework.views import APIView

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



