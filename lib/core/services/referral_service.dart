import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class ReferralService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Points for referring
  static const int referrerPoints = 50;
  static const int refereePoints = 25;

  // Generate referral code
  String generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(8, (_) => chars[random.nextInt(chars.length)]).join();
  }

  // Get or create referral code
  Future<String> getReferralCode() async {
    if (_userId == null) return '';
    final doc = await _firestore
        .collection('users')
        .doc(_userId)
        .get();

    if (doc.data()?['referralCode'] != null) {
      return doc.data()!['referralCode'];
    }

    final code = generateReferralCode();
    await _firestore.collection('users').doc(_userId).set({
      'referralCode': code,
      'totalReferrals': 0,
    }, SetOptions(merge: true));

    return code;
  }

  // Apply referral code
  Future<bool> applyReferralCode(String code) async {
    if (_userId == null) return false;

    // Find referrer
    final query = await _firestore
        .collection('users')
        .where('referralCode', isEqualTo: code)
        .get();

    if (query.docs.isEmpty) return false;

    final referrerId = query.docs.first.id;
    if (referrerId == _userId) return false;

    // Add points to referrer
    await _firestore.collection('users').doc(referrerId).update({
      'loyaltyPoints': FieldValue.increment(referrerPoints),
      'totalReferrals': FieldValue.increment(1),
    });

    // Add points to referee
    await _firestore.collection('users').doc(_userId).update({
      'loyaltyPoints': FieldValue.increment(refereePoints),
      'referredBy': referrerId,
    });

    return true;
  }

  // Get referral stats
  Future<Map<String, dynamic>> getReferralStats() async {
    if (_userId == null) return {};
    final doc = await _firestore
        .collection('users')
        .doc(_userId)
        .get();
    return {
      'referralCode': doc.data()?['referralCode'] ?? '',
      'totalReferrals': doc.data()?['totalReferrals'] ?? 0,
      'loyaltyPoints': doc.data()?['loyaltyPoints'] ?? 0,
    };
  }
}