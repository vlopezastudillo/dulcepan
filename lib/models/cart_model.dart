import 'package:flutter/material.dart';
import 'product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void add(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  double get totalPrice =>
      _products.fold(0, (total, current) => total + current.price);
}