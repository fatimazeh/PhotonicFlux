import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velvetvnaity/Admin/ProductAccess.dart';

class EditProductPage extends StatefulWidget {
  final String docId;

  const EditProductPage({Key? key, required this.docId}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _imageUrlsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  Future<void> _loadProductData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .doc(widget.docId)
          .get();

      if (docSnapshot.exists) {
        final product = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _productNameController.text = product['productName'] ?? '';
          _productPriceController.text = product['productPrice']?.toString() ?? '';
          _imageUrlsController.text = (product['imageUrls'] as List<dynamic>?)?.join(', ') ?? '';
        });
      }
    } catch (e) {
      _showDialog(context, 'Error loading product data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text('Edit Products', style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white)),
        backgroundColor: const Color(0xFFA80C0C),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFAFAFA), Color(0xFFE0E0E0)], // Light gray gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
                image: _imageUrlsController.text.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(_imageUrlsController.text.split(',').first),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _imageUrlsController.text.isEmpty
                  ? const Center(child: Icon(Icons.image, color: Colors.white, size: 48))
                  : null,
            ),
            const SizedBox(width: 16),
            // Form Section
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('Products')
                                      .doc(widget.docId)
                                      .update({
                                    'productName': _productNameController.text,
                                    'productPrice': double.parse(_productPriceController.text),
                                    'imageUrls': _imageUrlsController.text.split(',').map((url) => url.trim()).toList(),
                                  });
                                  _showDialog(context, 'Product updated successfully!');
                                  await Future.delayed(const Duration(seconds: 1));
                                  Navigator.popUntil(context, ModalRoute.withName(ProductAccess.id));
                                } catch (e) {
                                  _showDialog(context, 'Error updating product: $e');
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB71C1C), // Dark red
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text('Update Product', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.popUntil(context, ModalRoute.withName(ProductAccess.id));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Gray color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
        labelStyle: const TextStyle(color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
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
          title: const Text('Product Update', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
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
