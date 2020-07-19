
from rest_framework import serializers
from .models import User


class UserSerializer(serializers.ModelSerializer):
      class Meta:
            fields = ('username', 'id', 'first_name', 'last_name','email', 'role', 'bio')
            model = User
