import 'package:flutter/foundation.dart';
import 'product.dart';

class DataProvider with ChangeNotifier {
  final List<Product> _productsList = [];
  final List<Product> _addedProducts = [];

  List<Product> get productsList => List.unmodifiable(_productsList);
  List<Product> get addedProducts => List.unmodifiable(_addedProducts);

  int get itemCount => _addedProducts.length;

  void addProduct(Product product) {
    if (!_productsList.contains(product)) {
      _productsList.add(product);
      notifyListeners();
    }
  }

  void setProducts(List<Product> products) {
    _productsList
      ..clear()
      ..addAll(products);
    notifyListeners();
  }

    void toggleProductStatus(Product product) {
    if (_addedProducts.contains(product)) {
      _addedProducts.remove(product);
    } else {
      _addedProducts.add(product);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    return _addedProducts.fold(0.0, (total, product) => total + product.productPrice);
  }

  void clearCart() {
    _addedProducts.clear();
    notifyListeners();
  }

  List<Product> getAddedProducts() {
    return List.unmodifiable(_addedProducts);
  }

}
