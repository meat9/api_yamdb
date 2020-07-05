from rest_framework import permissions
from rest_framework.permissions import BasePermission


class ModPerm(permissions.BasePermission):

    def has_permission(self, request, view):
        return request.user.is_staff or request.auth and request.user.role == 'moderator'
    
    
class AdmPerm(permissions.BasePermission):

    def has_permission(self, request, view):
        return request.user.is_superuser or request.auth and request.user.role == 'admin'
            

class UserPerm(permissions.BasePermission):

    def has_permission(self, request, view):
        return request.user.is_authenticated or request.auth and request.user.role == 'user'
