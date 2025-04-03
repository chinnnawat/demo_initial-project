from django.db import models

class UserManager(models.Manager):
    def get_user_by_id(self, user_id):
        """
        Get user by user_id.
        """
        return self.get(id=user_id)