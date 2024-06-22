from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, EmailVerification, ResetPasswordVerification

# Register your models here.
# Register your models here.
class EmailVerificationAdmin(admin.ModelAdmin):
    list_display = ['user', 'verification_code', 'created_at']
    
class ResetPasswordVerificationAdmin(admin.ModelAdmin):
    list_display = ['user', 'verification_code', 'created_at']


admin.site.register(User)
admin.site.register(EmailVerification, EmailVerificationAdmin)
admin.site.register(ResetPasswordVerification, ResetPasswordVerificationAdmin)
