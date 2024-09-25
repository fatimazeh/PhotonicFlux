import 'package:flutter/material.dart';

// Product model
class Product {
  final String name;
  final String description;
  final double price;
  final String imagePath;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  get isAdded => null;
}

// Dummy product data
List<Product> products = [
  Product(
    name: "Solar Panel",
    description:
        "Solar panels are devices that convert sunlight into electricity through the photovoltaic effect.",
    price: 299.99,
    imagePath: 'assets/images/Photoes/Accessories/Solarpanel.jpg', // Use relative path for assets
  ),
  Product(
    name: "Solar Battery",
    description:
        "A rechargeable battery that integrates with solar panels to store energy for later use.",
    price: 149.99,
    imagePath: 'assets/images/Photoes/Accessories/solar_battery.jpg',
  ),
  Product(
    name: "Solar Inverter",
    description:
        "An essential device that converts direct current (DC) electricity from solar panels to alternating current (AC) for use in your home.",
    price: 199.99,
    imagePath: 'assets/images/Photoes/Accessories/inverters.jpg',
  ),
];

// Shop page widget
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFFA80C0C),
        title: const Text(
          'Accessories',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shadowColor: const Color(0xFFA80C0C),
            elevation: 10,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Image.asset(
                    products[index].imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  // Product Name
                  Text(
                    products[index].name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Product Description
                  Text(
                    products[index].description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  // Product Price
                  Text(
                    "\$ ${products[index].price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA80C0C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Buy Now Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement buy now functionality here
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Buy Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                "Confirm adding ${products[index].name} to cart?",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Navigate to Add to Cart page or implement cart logic
                                    // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => const AddToCartPage()));
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              backgroundColor: Colors.black,
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA80C0C),
                      ),
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ShopPage(),
  ));
}
