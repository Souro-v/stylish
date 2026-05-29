import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoyaltyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Points per ₹100 spent
  static const int pointsPerHundred = 10;

  // ₹1 discount per point
  static const double discountPerPoint = 1.0;

  // Get points balance
  Stream<int> getPointsBalance() {
    if (_userId == null) return Stream.value(0);
    return _firestore
        .collection('users')
        .doc(_userId)
        .snapshots()
        .map((doc) => (doc.data()?['loyaltyPoints'] as int?) ?? 0);
  }

  // Add points after order
  Future<void> addPoints(double orderAmount) async {
    if (_userId == null) return;
    final points = (orderAmount / 100 * pointsPerHundred).floor();
    await _firestore.collection('users').doc(_userId).set({
      'loyaltyPoints': FieldValue.increment(points),
    }, SetOptions(merge: true));

    // Save transaction
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('loyalty_transactions')
        .add({
      'points': points,
      'type': 'earned',
      'description': 'Order reward',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Redeem points
  Future<bool> redeemPoints(int points) async {
    if (_userId == null) return false;
    final doc = await _firestore.collection('users').doc(_userId).get();
    final currentPoints = (doc.data()?['loyaltyPoints'] as int?) ?? 0;

    if (currentPoints < points) return false;

    await _firestore.collection('users').doc(_userId).update({
      'loyaltyPoints': FieldValue.increment(-points),
    });

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('loyalty_transactions')
        .add({
      'points': -points,
      'type': 'redeemed',
      'description': 'Points redeemed for discount',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return true;
  }

  // Get transactions
  Stream<List<Map<String, dynamic>>> getTransactions() {
    if (_userId == null) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('loyalty_transactions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Calculate discount
  double calculateDiscount(int points) {
    return points * discountPerPoint;
  }
}
