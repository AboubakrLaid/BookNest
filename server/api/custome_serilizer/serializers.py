from rest_framework.serializers import Serializer
from rest_framework.utils.serializer_helpers import ReturnDict

def custom_error(errors_dict):
    errors = {}
    for key, value in errors_dict.items():
        if isinstance(value, list):
            if len(value) > 0:

                errors[key] = {
                    "message": str(value[0]),
                    "code": value[0].code
                }
        elif isinstance(value, dict):
            errors[key] = custom_error(value)

    return errors

class CustomErrorSerializerMixin:
    
    @property
    def errors(self):
        original_errors = super().errors
        if isinstance(original_errors, ReturnDict):
            original_errors = dict(original_errors)
        formatted_errors = custom_error(original_errors)
        return ReturnDict(formatted_errors, serializer=self)

