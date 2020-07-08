
from rest_framework import serializers
from .models import User

from django.utils.translation import ugettext_lazy as _


class UserSerializer(serializers.ModelSerializer):
      class Meta:
            fields = ('username', 'id', 'first_name', 'last_name', 'password','email', 'role', 'bio')
            model = User
      def create(self, validated_data):
            user = super().create(validated_data)
            user.set_password(validated_data['password'])
            user.save()
            return user