from rest_framework import permissions
from rest_framework.permissions import BasePermission


class AdminPerm(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.user.is_authenticated:
            return request.user.is_staff or request.user.role == 'admin'
        else:
            return False


class AdminOrReadPerm(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        if request.user.is_authenticated:
            return request.user.is_staff or request.user.role == 'admin'
        else:
            return False


class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.method in permissions.SAFE_METHODS or request.user and request.user.is_authenticated

    def has_object_permission(self, request, view, obj):
        return request.user == obj.author or request.method in permissions.SAFE_METHODS


class ModeratorOrAuthorPerm(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.method in permissions.SAFE_METHODS or request.user and request.user.is_authenticated

    def has_object_permission(self, request, view, obj):
        if request.user and request.user.is_authenticated:
            if (request.user.is_staff or request.user.role == 'admin' or
                    request.user.role == 'moderator' or
                    obj.author == request.user or
                    request.method == 'POST' and request.user.is_authenticated):
                return True
        elif request.method in permissions.SAFE_METHODS:
            return True
        else:
            return False
