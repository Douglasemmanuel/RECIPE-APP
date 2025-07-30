import '../models/recipe.dart';

class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Recipe> _favorites = [];

  List<Recipe> get favorites => List.unmodifiable(_favorites);

  void toggleFavorite(Recipe recipe) {
    if (isFavorite(recipe)) {
      _favorites.removeWhere((r) => r.id == recipe.id);
    } else {
      _favorites.add(recipe);
    }
  }

  bool isFavorite(Recipe recipe) {
    return _favorites.any((r) => r.id == recipe.id);
  }
}

