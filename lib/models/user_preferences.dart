import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _favoriteKey = 'favorite_items';
  static const String _cartKey = 'cart_items';

  /// Save favorite items (List of Recipe IDs)
  static Future<void> saveFavorites(List<String> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteKey, favoriteIds);
  }

  /// Load favorite items
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteKey) ?? [];
  }

  /// Save cart items (List of Recipe IDs)
  static Future<void> saveCart(List<String> cartIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_cartKey, cartIds);
  }

  /// Load cart items
  static Future<List<String>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_cartKey) ?? [];
  }
}
