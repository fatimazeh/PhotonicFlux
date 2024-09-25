import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/PaymentInfo.dart';

import 'package:velvetvnaity/model/product.dart';

class CartPage extends StatelessWidget {
  final List<Product> cart;
  final Function(Product) onRemove;
  final double totalAmount;
  final void Function() onClearCart;

  const CartPage({
    required this.cart,
    required this.onRemove,
    required this.totalAmount,
    required this.onClearCart,
    Key? key,
  }) : super(key: key);

  void _placeOrder(BuildContext context) async {
    // Navigate to the BillingInfoPage and await result
    final billingInfo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillingInfoPage(
          cart: cart,
          totalAmount: totalAmount,
        ),
      ),
    );

    if (billingInfo != null) {
      // Add order to Firestore with billing info
      final orderRef = FirebaseFirestore.instance.collection('orders').doc();
      await orderRef.set({
        'totalAmount': totalAmount,
        'items': cart.map((product) => product.toJson()).toList(),
        'timestamp': FieldValue.serverTimestamp(),
        'billingInfo': billingInfo.toJson(), // Save billing info
      });

      // Optionally, you can clear the cart or show a confirmation message here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFFA80C0C),
        actions: [
          if (cart.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: onClearCart,
            ),
        ],
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];
                      return _buildCartItem(product);
                    },
                  ),
                ),
                _buildTotalAmount(),
                _buildPlaceOrderButton(context),
              ],
            ),
    );
  }

  Widget _buildCartItem(Product product) {
    return ListTile(
      title: Text(product.productName),
      subtitle: Text('\$${product.productPrice.toStringAsFixed(2)}'),
      leading: Image.network(
        product.imageUrls.isNotEmpty ? product.imageUrls.first : '',
        width: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/placeholder.png');
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle, color: Color(0xFFA80C0C)),
        onPressed: () {
          onRemove(product);
        },
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () => _placeOrder(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA80C0C),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: const Text('Place Order',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
