import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velvetvnaity/Admin/EditProduct.dart';

class ProductAccess extends StatelessWidget {
  static const String id = "ProductAccess";

  const ProductAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Product Access', style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white)),
        backgroundColor: const Color(0xFFA80C0C),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFAFAFA), Color(0xFFE0E0E0)], // Light gray gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final products = snapshot.data?.docs ?? [];

            if (products.isEmpty) {
              return Center(child: Text('No products found.'));
            }

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index].data() as Map<String, dynamic>;
                final docId = products[index].id;

                return _buildProductCard(context, product, docId);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product, String docId) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          product['productName'] ?? 'No name',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price: \$${product['productPrice']?.toStringAsFixed(2) ?? '0.00'}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Images: ${product['imageUrls']?.join(', ') ?? 'No images'}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.0), // Add space before details
            Text(
              'Details: ${product['details'] ?? 'No details available'}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'Edit') {
              // Navigate to EditProductPage with the document ID
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductPage(docId: docId),
                ),
              );
            } else if (value == 'Delete') {
              await FirebaseFirestore.instance
                  .collection('Products')
                  .doc(docId)
                  .delete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Product deleted successfully!')),
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'Edit',
              child: Text('Edit'),
            ),
            PopupMenuItem(
              value: 'Delete',
              child: const Text('Delete'),
            ),
          ],
          icon: Icon(Icons.more_vert, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('routeName', id));
  }
}
