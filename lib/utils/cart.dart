import '../models/recipe.dart'; // Replace with your actual model
import  '../models/user_preferences.dart';
import 'dart:convert';
import '../models/ingredient.dart'; 
import '../models/nutrition_info.dart'; 

class CartManager {
  // ✅ Singleton instance
  static final CartManager _instance = CartManager._internal();
  CartManager._internal();
  factory CartManager() => _instance;

  // ✅ Public instance getter (so you can use CartManager.instance)
  static CartManager get instance => _instance;

  final Map<String, CartItem> _cartItems = {};

  List<CartItem> get cartItems => _cartItems.values.toList();

  void addToCart(Recipe recipe) {
    if (_cartItems.containsKey(recipe.id)) {
      _cartItems[recipe.id]!.quantity++;
    } else {
      _cartItems[recipe.id] = CartItem(recipe: recipe, quantity: 1);
    }
    saveCartItems();
  }

  void removeFromCart(String recipeId) {
    _cartItems.remove(recipeId);
    saveCartItems();
  }

  void updateQuantity(String recipeId, int quantity) {
    if (_cartItems.containsKey(recipeId)) {
      if (quantity <= 0) {
        _cartItems.remove(recipeId);
      } else {
        _cartItems[recipeId]!.quantity = quantity;
      }
      saveCartItems();
    }
  }

  int getTotalItems() {
    return _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double getTotalPrice() {
    return _cartItems.values.fold(
        0.0, (sum, item) => sum + item.recipe.price * item.quantity);
  }

  void clearCart() {
    _cartItems.clear();
    saveCartItems();
  }

  Future<void> saveCartItems() async {
    final cartIds = _cartItems.keys.toList(); // Save only recipe IDs
    await UserPreferences.saveCartItems(cartIds);
  }

  Future<void> loadCartItems(List<Recipe> allRecipes) async {
    final cartIds = await UserPreferences.getCartItems();
    _cartItems.clear();

    for (var id in cartIds) {
      final recipe = allRecipes.firstWhere(
        (r) => r.id == id,
        orElse: () => 
        Recipe(
  id: '',
  title: '',
  description: '',
  price: 0,
  imageUrl: '',
  additionalImages: [],
  cookTimeMinutes: 0,
  prepTimeMinutes: 0,
  servings: 0,
  difficulty: '',
  ingredients: [],
  instructions: [],
  tags: [],
  nutritionInfo: NutritionInfo(
    calories: 0,
    protein: 0,
    carbs: 0,
    fat: 0,
    fiber: 0,
    sugar: 0,
    sodium: 0,
  ),
  rating: 0.0,
  reviewCount: 0,
  category: '',
  createdAt: DateTime(2000, 1, 1),
)
// fallback
      );

      if (recipe.id.isNotEmpty) {
        _cartItems[id] = CartItem(recipe: recipe, quantity: 1);
      }
    }
  }
}


class CartItem {
  final Recipe recipe;
  int quantity;

  CartItem({required this.recipe, required this.quantity});

  
}