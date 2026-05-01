import 'package:flutter/material.dart';
import 'package:stylish/screens/products/trending_screen.dart';
import '../../screens/products/product_detail_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/auth/sign_in_screen.dart';
import '../../screens/auth/sign_up_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/checkout/checkout_screen.dart';

class AppRoutes {
  AppRoutes._();

  // Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String checkout = '/checkout';
  static const String trending = '/trending';


  // Route Generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case productDetail:
        return MaterialPageRoute(builder: (_) => const ProductDetailScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case trending:
        return MaterialPageRoute(builder: (_) => const TrendingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found!')),
          ),
        );
    }
  }
}