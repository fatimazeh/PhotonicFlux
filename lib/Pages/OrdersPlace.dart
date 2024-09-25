import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Product> cart;
  final Function(Product) onRemove;

  CartPage({required this.cart, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFFA80C0C), // Accent color
      ),
      body: cart.isEmpty
          ? Center(child: Text('Your cart is empty', style: TextStyle(fontSize: 18)))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return ListTile(
                  title: Text(product.productName),
                  subtitle: Text('\$${product.productPrice.toStringAsFixed(2)}'),
                  leading: Image.network(
                    product.imageUrls.isNotEmpty ? product.imageUrls.first : '',
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/placeholder.png'); // Replace with your own placeholder image
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Color(0xFFA80C0C)),
                    onPressed: () {
                      onRemove(product); // Call the remove callback
                    },
                  ),
                );
              },
            ),
    );
  }
}

class Product {
  final String productName;
  final double productPrice;
  final List<String> imageUrls;

  Product({required this.productName, required this.productPrice, required this.imageUrls});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] ?? 'No Name',
      productPrice: (map['productPrice'] ?? 0.0).toDouble(),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
}
