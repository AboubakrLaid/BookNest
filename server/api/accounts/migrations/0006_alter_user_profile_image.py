# Generated by Django 5.0.1 on 2024-02-15 02:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0005_user_profile_image'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='profile_image',
            field=models.ImageField(blank=True, height_field=100, null=True, upload_to='', width_field=100),
        ),
    ]
