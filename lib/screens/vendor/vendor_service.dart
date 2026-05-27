import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VendorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Register as vendor
  Future<void> registerVendor(Map<String, dynamic> vendorData) async {
    if (_userId == null) return;
    await _firestore.collection('vendors').doc(_userId).set({
      ...vendorData,
      'uid': _userId,
      'isApproved': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Check if vendor
  Future<bool> isVendor() async {
    if (_userId == null) return false;
    final doc =
    await _firestore.collection('vendors').doc(_userId).get();
    return doc.exists;
  }

  // Get vendor data
  Future<Map<String, dynamic>?> getVendorData() async {
    if (_userId == null) return null;
    final doc =
    await _firestore.collection('vendors').doc(_userId).get();
    return doc.data();
  }

  // Add product
  Future<void> addProduct(Map<String, dynamic> product) async {
    if (_userId == null) return;
    await _firestore.collection('products').add({
      ...product,
      'vendorId': _userId,
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': true,
    });
  }

  // Get vendor products
  Stream<List<Map<String, dynamic>>> getVendorProducts() {
    if (_userId == null) return Stream.value([]);
    return _firestore
        .collection('products')
        .where('vendorId', isEqualTo: _userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .toList());
  }

  // Delete product
  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  // Update product
  Future<void> updateProduct(
      String productId, Map<String, dynamic> data) async {
    await _firestore
        .collection('products')
        .doc(productId)
        .update(data);
  }

  // Get vendor orders
  Stream<List<Map<String, dynamic>>> getVendorOrders() {
    if (_userId == null) return Stream.value([]);
    return _firestore
        .collection('orders')
        .where('vendorId', isEqualTo: _userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .toList());
  }
}