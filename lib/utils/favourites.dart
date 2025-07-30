// import '../models/recipe.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// class FavoritesManager {
//   static final FavoritesManager _instance = FavoritesManager._internal();
//   factory FavoritesManager() => _instance;
//   FavoritesManager._internal();

//   final List<Recipe> _favorites = [];

//   List<Recipe> get favorites => List.unmodifiable(_favorites);

//   void toggleFavorite(Recipe recipe) {
//     if (isFavorite(recipe)) {
//       _favorites.removeWhere((r) => r.id == recipe.id);
//     } else {
//       _favorites.add(recipe);
//     }
//   }

//   bool isFavorite(Recipe recipe) {
//     return _favorites.any((r) => r.id == recipe.id);
//   }
// }




import '../models/recipe.dart';
import '../models/user_preferences.dart';

class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Recipe> _favorites = [];

  List<Recipe> get favorites => List.unmodifiable(_favorites);

  /// Load favorites from local storage and match them with all recipes
  Future<void> loadFavorites(List<Recipe> allRecipes) async {
    final favoriteIds = await UserPreferences.getFavorites();
    _favorites.clear();
    _favorites.addAll(
      allRecipes.where((recipe) => favoriteIds.contains(recipe.id)),
    );
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    if (isFavorite(recipe)) {
      _favorites.removeWhere((r) => r.id == recipe.id);
    } else {
      _favorites.add(recipe);
    }

    await _saveFavoritesToPreferences();
  }

  bool isFavorite(Recipe recipe) {
    return _favorites.any((r) => r.id == recipe.id);
  }

  Future<void> _saveFavoritesToPreferences() async {
    final favoriteIds = _favorites.map((r) => r.id).toList();
    await UserPreferences.saveFavorites(favoriteIds);
  }
}


