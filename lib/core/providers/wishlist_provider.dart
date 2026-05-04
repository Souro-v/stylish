import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _wishlistItems = [];

  List<Map<String, dynamic>> get wishlistItems => _wishlistItems;

  bool isWishlisted(String productName) {
    return _wishlistItems.any((item) => item['name'] == productName);
  }

  void toggleWishlist(Map<String, dynamic> product) {
    if (isWishlisted(product['name'])) {
      _wishlistItems.removeWhere(
              (item) => item['name'] == product['name']);
    } else {
      _wishlistItems.add(product);
    }
    notifyListeners();
  }
}