import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailsPage extends StatelessWidget {
  
  final String productId;

  const ProductDetailsPage({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Products').doc(productId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No product found.'));
          }

          final product = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['productName'] ?? 'No Name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${(product['productPrice'] as num).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                _getImage(product['imageUrls']?.isNotEmpty == true ? product['imageUrls'].first : ''),
                SizedBox(height: 16),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  product['description'] ?? 'No description available.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getImage(String imageUrl) {
    return imageUrl.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/placeholder.png');
              },
            ),
          )
        : Container(
            height: 200,
            color: Colors.grey[200],
            child: Center(child: Text('No Image Available')),
          );
  }
}
