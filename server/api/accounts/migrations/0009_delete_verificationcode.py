# Generated by Django 5.0.1 on 2024-02-15 05:49

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0008_verificationcode'),
    ]

    operations = [
        migrations.DeleteModel(
            name='VerificationCode',
        ),
    ]