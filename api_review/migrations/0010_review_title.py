# Generated by Django 3.0.5 on 2020-07-16 11:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api_titles', '0002_auto_20200713_0635'),
        ('api_review', '0009_auto_20200716_1435'),
    ]

    operations = [
        migrations.AddField(
            model_name='review',
            name='title',
            field=models.ManyToManyField(blank=True, null=True, related_name='title_review', to='api_titles.Title'),
        ),
    ]