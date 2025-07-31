import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _favoriteKey = 'favorite_items';
  static const String _cartKey     = 'cart_items';

  static Future<void> saveFavorites(List<String> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteKey, favoriteIds);
  }

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteKey) ?? [];
  }

  static Future<void> saveCartItems(List<String> cartIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_cartKey, cartIds);
  }

  static Future<List<String>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_cartKey) ?? [];
  }
}
