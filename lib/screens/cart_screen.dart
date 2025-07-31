import 'package:flutter/material.dart';
import '../../utils/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartManager _cartManager = CartManager();

  @override
  Widget build(BuildContext context) {
    final cartItems = _cartManager.cartItems;

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (_, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.network(item.recipe.imageUrl, width: 50, height: 50),
                        title: Text(item.recipe.title),
                        subtitle: Text('\ ₦${item.recipe.price} x ${item.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  _cartManager.updateQuantity(item.recipe.id, item.quantity - 1);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _cartManager.updateQuantity(item.recipe.id, item.quantity + 1);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _cartManager.removeFromCart(item.recipe.id);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Total Items: ${_cartManager.getTotalItems()}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: \$${_cartManager.getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Checkout or clear
                          setState(() {
                            _cartManager.clearCart();
                          });
                        },
                        child: const Text('Checkout / Clear Cart'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

