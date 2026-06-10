import 'package:cloud_firestore/cloud_firestore.dart';

class CouponService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Predefined coupons
  final Map<String, Map<String, dynamic>> _coupons = {
    'STYLISH10': {'discount': 10, 'type': 'percentage', 'minOrder': 500},
    'FLAT50': {'discount': 50, 'type': 'flat', 'minOrder': 200},
    'WELCOME20': {'discount': 20, 'type': 'percentage', 'minOrder': 300},
    'SAVE100': {'discount': 100, 'type': 'flat', 'minOrder': 1000},
    'FESTIVE15': {'discount': 15, 'type': 'percentage', 'minOrder': 400},
  };

  // Validate coupon
  Map<String, dynamic>? validateCoupon(
      String code, double orderAmount) {
    final coupon = _coupons[code.toUpperCase()];
    if (coupon == null) return null;
    if (orderAmount < (coupon['minOrder'] as num)) return null;
    return coupon;
  }

  // Calculate discount
  double calculateDiscount(
      Map<String, dynamic> coupon, double orderAmount) {
    if (coupon['type'] == 'percentage') {
      return orderAmount * (coupon['discount'] as num) / 100;
    }
    return (coupon['discount'] as num).toDouble();
  }
}