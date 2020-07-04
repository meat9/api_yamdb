from rest_framework import serializers
from .models import User
from rest_framework.validators import UniqueValidator
from django.utils.translation import ugettext_lazy as _


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        fields = ('username', 'id', 'first_name', 'last_name', 'email', 'role', 'bio')
        model = User

    def create(self, validated_data):
        user = User.objects.create(**validated_data)
        user.save() 
        role=self.validated_data.get('role')
        if role == 'moderator':
            user.is_staff = True
            user.save()
        elif role == 'admin':
            user.is_superuser = True
            user.save()
        return user
    

    



#class TokSerializer(TokenObtainPairSerializer):
    

   # def __init__(self, *args, **kwargs):
    #    super(User, self).__init__(*args, **kwargs)
        #email = serializers.EmailField()
     #   self.fields['email'] = serializers.EmailField()
    #    del self.fields[self.username_field]
     #   del self.fields['password']
    
   # def validate(self, attrs):
      #  email = attrs['email']
      #  authenticate_kwargs = {'email': attrs['email']}
        #try:
         #   authenticate_kwargs['request'] = self.context['request']
        #except KeyError:
         #   pass
        #self.user = authenticate(**authenticate_kwargs)