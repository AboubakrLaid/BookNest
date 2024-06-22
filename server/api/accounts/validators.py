from .models import User
from rest_framework.validators import UniqueValidator, UniqueTogetherValidator

unique_username = [
    UniqueValidator(
        queryset=User.objects.all(),
        lookup="exact",
        message="Username already taken.",
    )
]

unique_email = [
    UniqueValidator(
        queryset=User.objects.all(), lookup="exact", message="email already used"
    )
]

unique_firstname_lastname_together = UniqueTogetherValidator(
    queryset=User.objects.all(),
    fields=["first_name", "last_name"],
    message="this fullname already exist",
)
