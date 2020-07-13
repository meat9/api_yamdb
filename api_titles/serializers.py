from rest_framework import serializers
from .models import Category, Genre, Title


class CategorySerializer(serializers.ModelSerializer):

    class Meta:
        fields = ('name', 'slug')
        model = Category


class GenreSerializer(serializers.ModelSerializer):

    class Meta:
        fields = ('name', 'slug')
        model = Genre


class TitleCreateSerializer(serializers.ModelSerializer):
    genre = serializers.SlugRelatedField(slug_field='slug', many=True, queryset=Genre.objects.all())
    category = serializers.SlugRelatedField(slug_field='slug', queryset=Category.objects.all())

    class Meta:
        fields = ('id', 'name', 'year', 'genre', 'category', 'description')
        model = Title


class TitleListSerializer(serializers.ModelSerializer):
    genre = GenreSerializer(many=True)
    category = CategorySerializer()
    rating = serializers.FloatField()

    class Meta:
        fields = ('id', 'name', 'year', 'genre', 'rating', 'category', 'description')
        model = Title
