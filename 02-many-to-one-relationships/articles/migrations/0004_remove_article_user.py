# Generated by Django 4.2.16 on 2024-10-11 02:25

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('articles', '0003_article_user'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='article',
            name='user',
        ),
    ]
