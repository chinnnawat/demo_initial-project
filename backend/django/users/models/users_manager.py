from django.db import models

class UserManager(models.Manager):
    """
    Custom manager for User model.
    """

    def get_queryset(self):
        """
        Returns the default queryset for the User model.
        """
        return self.filter(is_active=True)