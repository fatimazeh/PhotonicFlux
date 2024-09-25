class Product {
  final String productName;
  final double productPrice;
  final List<String> imageUrls;
  final String? details; // Updated to be nullable

  Product({
    required this.productName,
    required this.productPrice,
    required this.imageUrls,
    this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'imageUrls': imageUrls,
      'details': details, // Include details in toJson
    };
  }

  // Factory constructor to create a Product from a Map
  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      productName: data['productName'] as String,
      productPrice: (data['productPrice'] as num).toDouble(), // Ensure type safety
      imageUrls: List<String>.from(data['imageUrls'] as List),
      details: data['details'] as String?,
    );
  }

  static fromJson(item) {}
}
