import 'package:flutter/material.dart';
import 'package:velvetvnaity/model/product.dart';

class ReplyPage extends StatelessWidget {
    static const String id = "ReplyPage";
  final String userEmail;
  final String userName;
  final List<Product> orderDetails;

  ReplyPage({
    required this.userEmail,
    required this.userName,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reply to Order'),
        backgroundColor: Color(0xFFA80C0C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reply to: $userEmail', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Name: $userName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Order Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...orderDetails.map((product) => ListTile(
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
            )),
            // Add functionality to compose a reply here
          ],
        ),
      ),
    );
  }
}
