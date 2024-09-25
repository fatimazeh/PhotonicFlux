import 'package:flutter/material.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Cart'),
      ),
      body: const Center(
        child: Text('Add to Cart Page'), // Replace with your actual content
      ),
    );
  }
}