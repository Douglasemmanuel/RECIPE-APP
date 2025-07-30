import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(
        child: Text(
          'This is the Cart Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
