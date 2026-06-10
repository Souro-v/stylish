import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;
  String? get _userEmail => _auth.currentUser?.email;

  // Add review
  Future<void> addReview({
    required String productName,
    required double rating,
    required String review,
  }) async {
    if (_userId == null) return;
    await _firestore
        .collection('reviews')
        .doc(productName)
        .collection('user_reviews')
        .doc(_userId)
        .set({
      'userId': _userId,
      'userEmail': _userEmail ?? 'User',
      'rating': rating,
      'review': review,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Get reviews
  Stream<List<Map<String, dynamic>>> getReviews(String productName) {
    return _firestore
        .collection('reviews')
        .doc(productName)
        .collection('user_reviews')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Get average rating
  Future<double> getAverageRating(String productName) async {
    final snapshot = await _firestore
        .collection('reviews')
        .doc(productName)
        .collection('user_reviews')
        .get();
    if (snapshot.docs.isEmpty) return 0;
    double total = 0;
    for (final doc in snapshot.docs) {
      total += (doc.data()['rating'] as num).toDouble();
    }
    return total / snapshot.docs.length;
  }

  // Check if user already reviewed
  Future<bool> hasReviewed(String productName) async {
    if (_userId == null) return false;
    final doc = await _firestore
        .collection('reviews')
        .doc(productName)
        .collection('user_reviews')
        .doc(_userId)
        .get();
    return doc.exists;
  }
}