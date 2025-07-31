import '../models/recipe.dart';
import '../models/user_preferences.dart';





class FavoritesManager {
  // ✅ Singleton instance
  static final FavoritesManager instance = FavoritesManager._internal();

  FavoritesManager._internal();

  final List<Recipe> _favorites = [];

  List<Recipe> get favorites => _favorites;

  bool isFavorite(String recipeId) {
    return _favorites.any((r) => r.id == recipeId);
  }

  void toggleFavorite(Recipe recipe) async {
    if (isFavorite(recipe.id)) {
      _favorites.removeWhere((r) => r.id == recipe.id);
    } else {
      _favorites.add(recipe);
    }
    await save();
  }

  Future<void> load(List<Recipe> allRecipes) async {
    final ids = await UserPreferences.getFavorites();
    _favorites
      ..clear()
      ..addAll(allRecipes.where((r) => ids.contains(r.id)));
  }

  Future<void> save() async {
    final ids = _favorites.map((r) => r.id).toList();
    await UserPreferences.saveFavorites(ids);
  }
}
