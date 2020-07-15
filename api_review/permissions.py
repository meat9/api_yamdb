from rest_framework import status 
from rest_framework.response import Response 
from rest_framework import permissions 
 
class IsOwnerOrReadOnly(permissions.BasePermission): 
    def has_object_permission(self, request, view, obj): 
        if request.method in permissions.SAFE_METHODS: 
            return True 
        return obj.author == request.user 

class CommentPermission(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return bool(obj.author == request.user 
        or request.method in permissions.SAFE_METHODS or
        request.auth and request.user.role == 'admin'or 
        request.auth and request.user.role == 'moderator')