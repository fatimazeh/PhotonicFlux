import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductPage extends StatefulWidget {
  static const String id = "AddProductPage";

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _imageUrlsController = TextEditingController();
  final _detailsController = TextEditingController(); // New controller for Details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: Text('Add Products', style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white)),
        backgroundColor: const Color(0xFFA80C0C),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf5f5f5), Color(0xFFe0e0e0)], // Light gray gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextFormField(
                controller: _productNameController,
                label: 'Product Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildTextFormField(
                controller: _productPriceController,
                label: 'Product Price',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a product price';
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildTextFormField(
                controller: _imageUrlsController,
                label: 'Image URLs (comma separated)',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter image URLs';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildTextFormField(
                controller: _detailsController,
                label: 'Details',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseFirestore.instance
                          .collection('Products')
                          .add({
                        'productName': _productNameController.text,
                        'productPrice': double.parse(_productPriceController.text),
                        'imageUrls': _imageUrlsController.text.split(','),
                        'details': _detailsController.text, // Adding details field
                      });
                      _showDialog(context, 'Product added successfully!');
                      _productNameController.clear();
                      _productPriceController.clear();
                      _imageUrlsController.clear();
                      _detailsController.clear(); // Clear the new field
                      Navigator.pop(context);
                    } catch (e) {
                      _showDialog(context, 'Error adding product: $e');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA80C0C), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                ),
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Product Added'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
