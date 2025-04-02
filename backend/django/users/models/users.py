from django.db import models
from django.utils import timezone
from .users_manager import UserManager
class User(models.Model):
    """
    User model to store user information.
    """
    username = models.CharField(max_length=150, unique=True)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128)
    created_at = models.DateTimeField(default=timezone.now)
    updated_at = models.DateTimeField(auto_now=True)
    last_login = models.DateTimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)

    objects = UserManager()
    def __str__(self):
        return self.username