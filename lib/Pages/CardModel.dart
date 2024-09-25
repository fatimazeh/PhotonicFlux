class CartItem {
  final String productId;
  final String productName;
  final String productPrice;
  final String imageUrl;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
  });

  get itemCount => null;

  void addItem(Map<String, dynamic> data) {}
}
