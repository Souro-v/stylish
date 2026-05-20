import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class CartProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _cartItems = [];

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

  // Load cart from Firestore
  void loadCart() {
    _firestoreService.getCartItems().listen((items) {
      _cartItems = items;
      notifyListeners();
    });
  }

  // Add to cart
  Future<void> addToCart(Map<String, dynamic> product) async {
    if (isInCart(product['name'])) {
      final index = _cartItems
          .indexWhere((item) => item['name'] == product['name']);
      final newQty = (_cartItems[index]['qty'] as int) + 1;
      await _firestoreService.updateCartQty(product['name'], newQty);
    } else {
      await _firestoreService.addToCart(product);
    }
  }

  // Remove from cart
  Future<void> removeFromCart(String productName) async {
    await _firestoreService.removeFromCart(productName);
  }

  // Update qty
  Future<void> updateQty(String productName, int qty) async {
    await _firestoreService.updateCartQty(productName, qty);
  }

  // Update size
  Future<void> updateSize(String productName, String size) async {
    await _firestoreService.updateCartSize(productName, size);
  }

  // Clear cart
  Future<void> clearCart() async {
    await _firestoreService.clearCart();
  }
}