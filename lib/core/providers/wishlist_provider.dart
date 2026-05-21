import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class WishlistProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _wishlistItems = [];

  List<Map<String, dynamic>> get wishlistItems => _wishlistItems;

  bool isWishlisted(String productName) {
    return _wishlistItems.any((item) => item['name'] == productName);
  }

  // Load wishlist from Firestore
  void loadWishlist() {
    _firestoreService.getWishlistItems().listen((items) {
      _wishlistItems = items;
      notifyListeners();
    });
  }

  // Toggle wishlist
  Future<void> toggleWishlist(Map<String, dynamic> product) async {
    if (isWishlisted(product['name'])) {
      await _firestoreService.removeFromWishlist(product['name']);
    } else {
      await _firestoreService.addToWishlist(product);
    }
  }
}