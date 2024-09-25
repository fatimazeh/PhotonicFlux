import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velvetvnaity/Pages/CaradPage.dart';
import 'package:velvetvnaity/model/data_provider.dart';
import 'package:velvetvnaity/model/product.dart';

class ProductListPage extends StatefulWidget {
  static const String id = "ProductListPage";

  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final productsRef = _firestore.collection('Products');
      final productsSnapshot = await productsRef.get();
      final products = productsSnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      final dataProvider = Provider.of<DataProvider>(context, listen: false);
      dataProvider.setProducts(products);
    } catch (e) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching products: $e')),
      );
    }
  }

  void _showProductDetails(Product product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                '\$${product.productPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              ),
              SizedBox(height: 16),
              _getImage(product.imageUrls.isNotEmpty ? product.imageUrls.first : '', height: 90),
              SizedBox(height: 16),
              Text(
                'Description:',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 6),
              Text(
                product.details ?? 'No description available.',
                style: TextStyle(fontSize: 9, color: Colors.white),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the modal bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA80C0C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: Text('Close', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _clearCart() {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.clearCart(); // Clear the cart in the data provider
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Place Your Order', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(
                        cart: dataProvider.getAddedProducts(),
                        onRemove: (product) {
                          setState(() {
                            dataProvider.toggleProductStatus(product);
                          });
                        },
                        totalAmount: dataProvider.getTotalPrice(),
                        onClearCart: _clearCart,
                      ),
                    ),
                  );
                },
              ),
              if (dataProvider.itemCount > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFA80C0C),
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        '${dataProvider.itemCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFFA80C0C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                padding: EdgeInsets.all(16.0),
                itemCount: dataProvider.productsList.length,
                itemBuilder: (context, index) {
                  final product = dataProvider.productsList[index];
                  return _buildProductCard(product);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Price: \$${dataProvider.getTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getImage(product.imageUrls.isNotEmpty ? product.imageUrls.first : '', height: 200),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              product.productName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              '\$${product.productPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    final dataProvider = Provider.of<DataProvider>(context, listen: false);
                    dataProvider.toggleProductStatus(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA80C0C),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(fontSize: 12),
                  ),
                  child: Text(
                    Provider.of<DataProvider>(context).addedProducts.contains(product)
                        ? 'Remove from Cart'
                        : 'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => _showProductDetails(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(fontSize: 12),
                  ),
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _getImage(String imageUrl, {double height = 200}) {
    return imageUrl.isNotEmpty
        ? SizedBox(
            height: height,
            child: Image.network(
              imageUrl,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/placeholder.png');
              },
            ),
          )
        : Container(
            height: height,
            color: Colors.grey[200],
            child: Center(child: Text('No Image Available')),
          );
  }
}
