import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // ==================== USER ====================

  // Save user profile
  Future<void> saveUserProfile(Map<String, dynamic> data) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .set(data, SetOptions(merge: true));
  }

  // Get user profile
  Future<Map<String, dynamic>?> getUserProfile() async {
    if (_userId == null) return null;
    final doc =
    await _firestore.collection('users').doc(_userId).get();
    return doc.data();
  }

  // ==================== CART ====================

  // Add to cart
  Future<void> addToCart(Map<String, dynamic> product) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(product['name'])
        .set({...product, 'qty': 1, 'size': '42'});
  }

  // Get cart items
  Stream<List<Map<String, dynamic>>> getCartItems() {
    if (_userId == null) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Remove from cart
  Future<void> removeFromCart(String productName) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(productName)
        .delete();
  }

  // Update cart item qty
  Future<void> updateCartQty(String productName, int qty) async {
    if (_userId == null) return;
    if (qty <= 0) {
      await removeFromCart(productName);
      return;
    }
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(productName)
        .update({'qty': qty});
  }

  // Update cart item size
  Future<void> updateCartSize(String productName, String size) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(productName)
        .update({'size': size});
  }

  // Clear cart
  Future<void> clearCart() async {
    if (_userId == null) return;
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  // ==================== WISHLIST ====================

  // Add to wishlist
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('wishlist')
        .doc(product['name'])
        .set(product);
  }

  // Remove from wishlist
  Future<void> removeFromWishlist(String productName) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('wishlist')
        .doc(productName)
        .delete();
  }

  // Get wishlist items
  Stream<List<Map<String, dynamic>>> getWishlistItems() {
    if (_userId == null) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  // ==================== ORDERS ====================

  // Save order
  Future<void> saveOrder(Map<String, dynamic> orderData) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('orders')
        .add({
      ...orderData,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'Pending',
    });
  }

  // Get orders
  Stream<List<Map<String, dynamic>>> getOrders() {
    if (_userId == null) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }
}