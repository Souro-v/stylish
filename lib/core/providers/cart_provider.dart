import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  int get totalItems => _cartItems.length;

  double get totalPrice => _cartItems.fold(
    0,
        (sum, item) =>
    sum + (item['price'] as num) * (item['qty'] as num),
  );

  bool isInCart(String productName) {
    return _cartItems.any((item) => item['name'] == productName);
  }

  void addToCart(Map<String, dynamic> product) {
    if (isInCart(product['name'])) {
      // Already in cart — increase qty
      final index = _cartItems
          .indexWhere((item) => item['name'] == product['name']);
      _cartItems[index]['qty'] =
          (_cartItems[index]['qty'] as int) + 1;
    } else {
      _cartItems.add({...product, 'qty': 1, 'size': '42'});
    }
    notifyListeners();
  }

  void removeFromCart(String productName) {
    _cartItems.removeWhere((item) => item['name'] == productName);
    notifyListeners();
  }

  void updateQty(String productName, int qty) {
    final index =
    _cartItems.indexWhere((item) => item['name'] == productName);
    if (index != -1) {
      if (qty <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index]['qty'] = qty;
      }
      notifyListeners();
    }
  }

  void updateSize(String productName, String size) {
    final index =
    _cartItems.indexWhere((item) => item['name'] == productName);
    if (index != -1) {
      _cartItems[index]['size'] = size;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}