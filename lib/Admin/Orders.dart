import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velvetvnaity/Admin/ReplyPage.dart'; // Import the ReplyPage
import 'package:velvetvnaity/model/product.dart'; // Update import

class ProductSummaryPage extends StatefulWidget {
  static const String id = "ProductSummaryPage";

  final double totalAmount;
  final List<Product> cart;

  const ProductSummaryPage({
    required this.totalAmount,
    required this.cart,
    Key? key,
  }) : super(key: key);

  @override
  _ProductSummaryPageState createState() => _ProductSummaryPageState();
}

class _ProductSummaryPageState extends State<ProductSummaryPage> {
  Map<String, dynamic> _billingInfo = {};
  List<Product> _orderedProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchBillingInfo();
    _setOrderedProducts();
  }

  void _setOrderedProducts() {
    setState(() {
      _orderedProducts = widget.cart;
    });
  }

  Future<void> _fetchBillingInfo() async {
    try {
      final billingCollection = FirebaseFirestore.instance.collection('BillingInfo');
      final QuerySnapshot snapshot = await billingCollection.orderBy('timestamp', descending: true).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _billingInfo = snapshot.docs.first.data() as Map<String, dynamic>;
        });
      } else {
        print('No billing info found.');
      }
    } catch (e) {
      print('Error fetching billing info: $e'); // Print error to console
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch billing information: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _cancelOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order has been cancelled'),
        backgroundColor: Colors.white,
      ),
    );
    Navigator.pop(context); // Go back to the previous screen
  }

  void _confirmOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReplyPage(
          userEmail: _billingInfo['email'] ?? '',
          userName: _billingInfo['name'] ?? '',
          orderDetails: _orderedProducts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Summary',
          style: GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA80C0C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Billing Information
            Text(
              'Billing Information',
              style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBillingInfoRow('Full Name:', _billingInfo['name']),
            _buildBillingInfoRow('Email:', _billingInfo['email']),
            _buildBillingInfoRow('Address:', _billingInfo['address']),
            _buildBillingInfoRow('State:', _billingInfo['state']),
            _buildBillingInfoRow('Zip Code:', _billingInfo['zipCode']),
            _buildBillingInfoRow('Payment Method:', _billingInfo['paymentMethod']),
            const SizedBox(height: 24),

            // Ordered Products
            Text(
              'Ordered Products',
              style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_orderedProducts.isNotEmpty) ...[
              for (Product product in _orderedProducts)
                ListTile(
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
                ),
            ] else ...[
              Center(
                child: Text(
                  'No products found',
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _cancelOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Button color for cancel
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    textStyle: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Cancel Order',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: _confirmOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA80C0C), // Button color for confirm
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    textStyle: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Confirm Order',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingInfoRow(String label, dynamic value) {
    return Text(
      '$label ${value ?? 'N/A'}',
      style: GoogleFonts.roboto(fontSize: 18),
    );
  }
}
