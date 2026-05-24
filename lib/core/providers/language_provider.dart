import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_en.dart';
import '../l10n/app_bn.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'language';
  bool _isBangla = false;

  bool get isBangla => _isBangla;

  // Get current strings
  dynamic get strings => _isBangla ? AppBn() : AppEn();

  // Static getters for easy access
  String get appName =>
      _isBangla ? AppBn.appName : AppEn.appName;
  String get home => _isBangla ? AppBn.home : AppEn.home;
  String get wishlist =>
      _isBangla ? AppBn.wishlist : AppEn.wishlist;
  String get cart => _isBangla ? AppBn.cart : AppEn.cart;
  String get search => _isBangla ? AppBn.search : AppEn.search;
  String get profile =>
      _isBangla ? AppBn.profile : AppEn.profile;
  String get signIn => _isBangla ? AppBn.signIn : AppEn.signIn;
  String get signUp => _isBangla ? AppBn.signUp : AppEn.signUp;
  String get email => _isBangla ? AppBn.email : AppEn.email;
  String get password =>
      _isBangla ? AppBn.password : AppEn.password;
  String get login => _isBangla ? AppBn.login : AppEn.login;
  String get logout => _isBangla ? AppBn.logout : AppEn.logout;
  String get welcome =>
      _isBangla ? AppBn.welcome : AppEn.welcome;
  String get allFeatured =>
      _isBangla ? AppBn.allFeatured : AppEn.allFeatured;
  String get dealOfDay =>
      _isBangla ? AppBn.dealOfDay : AppEn.dealOfDay;
  String get trendingProducts =>
      _isBangla ? AppBn.trendingProducts : AppEn.trendingProducts;
  String get newArrivals =>
      _isBangla ? AppBn.newArrivals : AppEn.newArrivals;
  String get specialOffers =>
      _isBangla ? AppBn.specialOffers : AppEn.specialOffers;
  String get viewAll =>
      _isBangla ? AppBn.viewAll : AppEn.viewAll;
  String get addToCart =>
      _isBangla ? AppBn.addToCart : AppEn.addToCart;
  String get goToCart =>
      _isBangla ? AppBn.goToCart : AppEn.goToCart;
  String get buyNow => _isBangla ? AppBn.buyNow : AppEn.buyNow;
  String get addToWishlist =>
      _isBangla ? AppBn.addToWishlist : AppEn.addToWishlist;
  String get wishlisted =>
      _isBangla ? AppBn.wishlisted : AppEn.wishlisted;
  String get proceedToPayment =>
      _isBangla ? AppBn.proceedToPayment : AppEn.proceedToPayment;
  String get shoppingBag =>
      _isBangla ? AppBn.shoppingBag : AppEn.shoppingBag;
  String get orderTotal =>
      _isBangla ? AppBn.orderTotal : AppEn.orderTotal;
  String get myOrders =>
      _isBangla ? AppBn.myOrders : AppEn.myOrders;
  String get trackOrder =>
      _isBangla ? AppBn.trackOrder : AppEn.trackOrder;
  String get settings =>
      _isBangla ? AppBn.settings : AppEn.settings;
  String get darkMode =>
      _isBangla ? AppBn.darkMode : AppEn.darkMode;
  String get language =>
      _isBangla ? AppBn.language : AppEn.language;
  String get save => _isBangla ? AppBn.save : AppEn.save;
  String get flashSale =>
      _isBangla ? AppBn.flashSale : AppEn.flashSale;
  String get searchProduct =>
      _isBangla ? AppBn.searchProduct : AppEn.searchProduct;

  LanguageProvider() {
    _loadLanguage();
  }

  void toggleLanguage() {
    _isBangla = !_isBangla;
    _saveLanguage();
    notifyListeners();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _isBangla = prefs.getBool(_languageKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_languageKey, _isBangla);
  }
}