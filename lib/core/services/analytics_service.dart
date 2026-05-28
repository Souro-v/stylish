import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnalyticsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Track product view
  Future<void> trackProductView(String productName) async {
    await _firestore.collection('analytics').doc('product_views').set({
      productName: FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  // Get total orders
  Future<int> getTotalOrders() async {
    if (_userId == null) return 0;
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('orders')
        .get();
    return snapshot.docs.length;
  }

  // Get total spent
  Future<double> getTotalSpent() async {
    if (_userId == null) return 0;
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('orders')
        .get();
    double total = 0;
    for (final doc in snapshot.docs) {
      total += (doc.data()['totalPrice'] as num? ?? 0).toDouble();
    }
    return total;
  }

  // Get monthly orders
  Future<Map<String, int>> getMonthlyOrders() async {
    if (_userId == null) return {};
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('orders')
        .get();

    final Map<String, int> monthly = {};
    for (final doc in snapshot.docs) {
      final timestamp = doc.data()['createdAt'] as Timestamp?;
      if (timestamp != null) {
        final date = timestamp.toDate();
        final key = '${date.month}/${date.year}';
        monthly[key] = (monthly[key] ?? 0) + 1;
      }
    }
    return monthly;
  }

  // Get most viewed products
  Future<Map<String, dynamic>> getMostViewedProducts() async {
    final doc = await _firestore
        .collection('analytics')
        .doc('product_views')
        .get();
    return doc.data() ?? {};
  }
}