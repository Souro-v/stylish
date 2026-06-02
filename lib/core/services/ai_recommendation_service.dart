import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AiRecommendationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Get recommendations based on user activity
  Future<List<Map<String, dynamic>>> getRecommendations(
      List<Map<String, dynamic>> allProducts) async {
    try {
      if (_userId == null) return _getRandomProducts(allProducts);

      // Get user's wishlist
      final wishlistSnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('wishlist')
          .get();

      // Get user's cart
      final cartSnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .get();

      // Get user's orders
      final ordersSnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('orders')
          .get();

      // Collect all interacted product names
      final interactedNames = <String>{};

      for (final doc in wishlistSnapshot.docs) {
        interactedNames.add(doc.data()['name'] as String? ?? '');
      }
      for (final doc in cartSnapshot.docs) {
        interactedNames.add(doc.data()['name'] as String? ?? '');
      }
      for (final order in ordersSnapshot.docs) {
        final items = order.data()['items'] as List? ?? [];
        for (final item in items) {
          interactedNames.add(item['name'] as String? ?? '');
        }
      }

      if (interactedNames.isEmpty) {
        return _getRandomProducts(allProducts);
      }

      // Find products not yet interacted with
      final notInteracted = allProducts
          .where((p) => !interactedNames.contains(p['name']))
          .toList();

      // Shuffle and return top 6
      notInteracted.shuffle();
      return notInteracted.take(6).toList();
    } catch (e) {
      return _getRandomProducts(allProducts);
    }
  }

  // Random products fallback
  List<Map<String, dynamic>> _getRandomProducts(
      List<Map<String, dynamic>> products) {
    final shuffled = List<Map<String, dynamic>>.from(products);
    shuffled.shuffle();
    return shuffled.take(6).toList();
  }
}