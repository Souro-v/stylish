import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecentlyViewedService {
  static const String _key = 'recently_viewed';
  static const int _maxItems = 10;

  Future<void> addProduct(Map<String, dynamic> product) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList(_key) ?? [];

    // Remove if already exists
    items.removeWhere((item) {
      final decoded = jsonDecode(item) as Map<String, dynamic>;
      return decoded['name'] == product['name'];
    });

    // Add to front
    items.insert(0, jsonEncode(product));

    // Keep only max items
    if (items.length > _maxItems) {
      items.removeLast();
    }

    await prefs.setStringList(_key, items);
  }

  Future<List<Map<String, dynamic>>> getRecentlyViewed() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList(_key) ?? [];
    return items
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  Future<void> clearRecentlyViewed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}