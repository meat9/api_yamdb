from rest_framework import permissions
from rest_framework.permissions import BasePermission


class Moderator_auth(permissions.BasePermission):

    def has_permission(self, request, view):
        is_role_moderator = request.user.role == request.user.moderator
        return bool(is_role_moderator or request.user.is_staff)
    
class Admin_auth(permissions.BasePermission):

    def has_permission(self, request, view):
        is_role_admin = request.user.role == request.user.admin
        return bool(is_role_admin or request.user.is_superuser)
            

class User_auth(permissions.BasePermission):

    def has_permission(self, request, view):
        return bool(request.user.role == 'user')

