import '../models/recipe.dart'; // Replace with your actual model

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final Map<String, CartItem> _cartItems = {};

  List<CartItem> get cartItems => _cartItems.values.toList();

  void addToCart(Recipe recipe) {
    if (_cartItems.containsKey(recipe.id)) {
      _cartItems[recipe.id]!.quantity++;
    } else {
      _cartItems[recipe.id] = CartItem(recipe: recipe, quantity: 1);
    }
  }

  void removeFromCart(String recipeId) {
    if (_cartItems.containsKey(recipeId)) {
      _cartItems.remove(recipeId);
    }
  }

  void updateQuantity(String recipeId, int quantity) {
    if (_cartItems.containsKey(recipeId)) {
      if (quantity <= 0) {
        _cartItems.remove(recipeId);
      } else {
        _cartItems[recipeId]!.quantity = quantity;
      }
    }
  }

  int getTotalItems() {
    return _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double getTotalPrice() {
    return _cartItems.values.fold(0.0, (sum, item) => sum + item.recipe.price * item.quantity);
  }

  void clearCart() {
    _cartItems.clear();
  }
}

class CartItem {
  final Recipe recipe;
  int quantity;

  CartItem({required this.recipe, required this.quantity});
}
