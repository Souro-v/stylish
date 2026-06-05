import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;
  String? get _userEmail => _auth.currentUser?.email;

  // Send message
  Future<void> sendMessage(String message) async {
    if (_userId == null) return;
    await _firestore
        .collection('chats')
        .doc(_userId)
        .collection('messages')
        .add({
      'message': message,
      'senderId': _userId,
      'senderEmail': _userEmail ?? 'User',
      'isUser': true,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Auto reply after 1 second
    await Future.delayed(const Duration(seconds: 1));
    await _sendAutoReply(message);
  }

  // Auto reply
  Future<void> _sendAutoReply(String userMessage) async {
    if (_userId == null) return;
    final reply = _getAutoReply(userMessage);
    await _firestore
        .collection('chats')
        .doc(_userId)
        .collection('messages')
        .add({
      'message': reply,
      'senderId': 'support',
      'senderEmail': 'Stylish Support',
      'isUser': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Get messages
  Stream<List<Map<String, dynamic>>> getMessages() {
    if (_userId == null) return Stream.value([]);
    return _firestore
        .collection('chats')
        .doc(_userId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Auto reply logic
  String _getAutoReply(String message) {
    final lower = message.toLowerCase();
    if (lower.contains('order')) {
      return 'You can track your orders in the "My Orders" section. Need more help?';
    } else if (lower.contains('return') || lower.contains('refund')) {
      return 'Our return policy allows returns within 7 days. Please contact us at support@stylish.com';
    } else if (lower.contains('delivery') || lower.contains('shipping')) {
      return 'We deliver within 1-3 business days. Free delivery on orders above ₹500!';
    } else if (lower.contains('discount') || lower.contains('coupon')) {
      return 'Check our Flash Sale section for amazing discounts! Use loyalty points for extra savings.';
    } else if (lower.contains('payment')) {
      return 'We accept Visa, bKash, Nagad, and Rocket. All payments are secure!';
    } else if (lower.contains('hi') || lower.contains('hello')) {
      return 'Hello! Welcome to Stylish Support. How can I help you today? 😊';
    } else {
      return 'Thank you for contacting Stylish Support! Our team will get back to you within 24 hours. Is there anything else I can help you with?';
    }
  }
}