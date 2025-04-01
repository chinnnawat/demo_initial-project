from rest_framework import viewsets
from rest_framework.decorators import api_view
from .user_list_serializer import UserSerializer
from ..models import User

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer