# Generated by Django 4.2.16 on 2024-10-11 03:07

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('articles', '0006_comment_user'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='article',
            name='user',
        ),
    ]
