# Generated by Django 5.0.1 on 2024-02-15 01:08

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('comments', '0004_rename_user_comment_owner'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='comment',
            name='reporters',
            field=models.ManyToManyField(default=list, related_name='reporters', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='comment',
            name='likers',
            field=models.ManyToManyField(default=list, related_name='liked_comments', to=settings.AUTH_USER_MODEL),
        ),
    ]
