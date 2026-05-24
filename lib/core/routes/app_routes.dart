import 'package:flutter/material.dart';
import 'package:stylish/screens/products/wishlist_screen.dart';
import '../../screens/auth/otp_screen.dart';
import '../../screens/categories/category_screen.dart';
import '../../screens/checkout/place_order_screen.dart';
import '../../screens/home/deal_of_day_screen.dart';
import '../../screens/home/flash_sale_screen.dart';
import '../../screens/home/flat_heels_screen.dart';
import '../../screens/home/new_arrivals_screen.dart';
import '../../screens/home/special_offers_screen.dart';
import '../../screens/orders/order_tracking_screen.dart';
import '../../screens/orders/orders_screen.dart';
import '../../screens/products/product_detail_screen.dart';
import '../../screens/products/trending_screen.dart';
import '../../screens/search/search_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/auth/sign_in_screen.dart';
import '../../screens/auth/sign_up_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/checkout/checkout_screen.dart';
import '../constants/app_assets.dart';

class AppRoutes {
  AppRoutes._();

  // Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String trending = '/trending';
  static const String profile = '/profile';
  static const String checkout = '/checkout';
  static const String wishlist = '/wishlist';
  static const String placeOrder = '/place-order';
  static const String orders = '/orders';
  static const String orderTracking = '/order-tracking';
  static const String search = '/search';
  static const String newArrivals = '/new-arrivals';
  static const String dealOfDay = '/deal-of-day';
  static const String specialOffers = '/special-offers';
  static const String flatHeels = '/flat-heels';
  static const String flashSale = '/flash-sale';
  static const String beauty = '/beauty';
  static const String fashion = '/fashion';
  static const String kids = '/kids';
  static const String mens = '/mens';
  static const String womens = '/womens';
  static const String gifts = '/gifts';
  static const String summerSale = '/summer-sale';
  static const String sponsoredScreen = '/sponsored';

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
      case otp:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(
            verificationId: args['verificationId'],
            phoneNumber: args['phoneNumber'],
          ),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case productDetail:
        final product = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        );
      case trending:
        return MaterialPageRoute(builder: (_) => const TrendingScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistScreen());
      case placeOrder:
        return MaterialPageRoute(builder: (_) => const PlaceOrderScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case orderTracking:
        final data = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(orderData: data),
        );
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case newArrivals:
        return MaterialPageRoute(builder: (_) => const NewArrivalsScreen());
      case flashSale:
        return MaterialPageRoute(builder: (_) => const FlashSaleScreen());
      case dealOfDay:
        return MaterialPageRoute(builder: (_) => const DealOfDayScreen());
      case specialOffers:
        return MaterialPageRoute(builder: (_) => const SpecialOffersScreen());
      case flatHeels:
        return MaterialPageRoute(builder: (_) => const FlatHeelsScreen());
      case beauty:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(
            title: 'Beauty',
            products: [
              {
                'image': AppAssets.beauty1,
                'name': 'Beauty Product 1',
                'price': 599,
                'oldPrice': 999,
                'discount': '40%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.beauty2,
                'name': 'Beauty Product 2',
                'price': 799,
                'oldPrice': 1299,
                'discount': '38%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.beauty3,
                'name': 'Beauty Product 3',
                'price': 499,
                'oldPrice': 899,
                'discount': '44%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.beauty4,
                'name': 'Beauty Product 4',
                'price': 999,
                'oldPrice': 1799,
                'discount': '44%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.beauty5,
                'name': 'Beauty Product 5',
                'price': 699,
                'oldPrice': 1199,
                'discount': '42%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.beauty6,
                'name': 'Beauty Product 6',
                'price': 899,
                'oldPrice': 1499,
                'discount': '40%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.beauty7,
                'name': 'Beauty Product 7',
                'price': 1299,
                'oldPrice': 2199,
                'discount': '41%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.beauty8,
                'name': 'Beauty Product 8',
                'price': 749,
                'oldPrice': 1299,
                'discount': '42%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.beauty9,
                'name': 'Beauty Product 9',
                'price': 549,
                'oldPrice': 999,
                'discount': '45%Off',
                'rating': 4.5
              },
            ],
          ),
        );

      case fashion:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(
            title: 'Fashion',
            products: [
              {
                'image': AppAssets.fashion1,
                'name': 'Fashion Product 1',
                'price': 1299,
                'oldPrice': 2499,
                'discount': '48%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.fashion2,
                'name': 'Fashion Product 2',
                'price': 999,
                'oldPrice': 1799,
                'discount': '44%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.fashion3,
                'name': 'Fashion Product 3',
                'price': 1499,
                'oldPrice': 2999,
                'discount': '50%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.fashion4,
                'name': 'Fashion Product 4',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.fashion5,
                'name': 'Fashion Product 5',
                'price': 1799,
                'oldPrice': 3499,
                'discount': '49%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.fashion6,
                'name': 'Fashion Product 6',
                'price': 899,
                'oldPrice': 1699,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.fashion7,
                'name': 'Fashion Product 7',
                'price': 2199,
                'oldPrice': 3999,
                'discount': '45%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.fashion8,
                'name': 'Fashion Product 8',
                'price': 1599,
                'oldPrice': 2999,
                'discount': '47%Off',
                'rating': 4.0
              },
            ],
          ),
        );

      case kids:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(
            title: 'Kids',
            products: [
              {
                'image': AppAssets.kid1,
                'name': 'Kids Product 1',
                'price': 499,
                'oldPrice': 899,
                'discount': '44%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.kid2,
                'name': 'Kids Product 2',
                'price': 699,
                'oldPrice': 1299,
                'discount': '46%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.kid3,
                'name': 'Kids Product 3',
                'price': 399,
                'oldPrice': 699,
                'discount': '43%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.kid4,
                'name': 'Kids Product 4',
                'price': 599,
                'oldPrice': 999,
                'discount': '40%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.kid5,
                'name': 'Kids Product 5',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.kid6,
                'name': 'Kids Product 6',
                'price': 449,
                'oldPrice': 799,
                'discount': '44%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.kid7,
                'name': 'Kids Product 7',
                'price': 649,
                'oldPrice': 1199,
                'discount': '46%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.kid8,
                'name': 'Kids Product 8',
                'price': 549,
                'oldPrice': 999,
                'discount': '45%Off',
                'rating': 4.0
              },
            ],
          ),
        );

      case mens:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(
            title: 'Mens',
            products: [
              {
                'image': AppAssets.mens1,
                'name': 'Mens Product 1',
                'price': 999,
                'oldPrice': 1799,
                'discount': '44%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.mens2,
                'name': 'Mens Product 2',
                'price': 1299,
                'oldPrice': 2499,
                'discount': '48%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.mens3,
                'name': 'Mens Product 3',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.mens4,
                'name': 'Mens Product 4',
                'price': 1499,
                'oldPrice': 2799,
                'discount': '46%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.mens5,
                'name': 'Mens Product 5',
                'price': 699,
                'oldPrice': 1299,
                'discount': '46%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.mens6,
                'name': 'Mens Product 6',
                'price': 1799,
                'oldPrice': 3299,
                'discount': '45%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.mens7,
                'name': 'Mens Product 7',
                'price': 899,
                'oldPrice': 1599,
                'discount': '44%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.mens8,
                'name': 'Mens Product 8',
                'price': 1199,
                'oldPrice': 2199,
                'discount': '45%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.mens9,
                'name': 'Mens Product 9',
                'price': 999,
                'oldPrice': 1799,
                'discount': '44%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.mens10,
                'name': 'Mens Product 10',
                'price': 1599,
                'oldPrice': 2999,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.mens11,
                'name': 'Mens Product 11',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.mens12,
                'name': 'Mens Product 12',
                'price': 1099,
                'oldPrice': 1999,
                'discount': '45%Off',
                'rating': 4.0
              },
            ],
          ),
        );

      case womens:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(
            title: 'Womens',
            products: [
              {
                'image': AppAssets.womens1,
                'name': 'Womens Product 1',
                'price': 1299,
                'oldPrice': 2499,
                'discount': '48%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.womens2,
                'name': 'Womens Product 2',
                'price': 999,
                'oldPrice': 1799,
                'discount': '44%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.womens3,
                'name': 'Womens Product 3',
                'price': 1499,
                'oldPrice': 2999,
                'discount': '50%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.womens4,
                'name': 'Womens Product 4',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.womens5,
                'name': 'Womens Product 5',
                'price': 1799,
                'oldPrice': 3499,
                'discount': '49%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.womens6,
                'name': 'Womens Product 6',
                'price': 899,
                'oldPrice': 1699,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.womens7,
                'name': 'Womens Product 7',
                'price': 2199,
                'oldPrice': 3999,
                'discount': '45%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.womens8,
                'name': 'Womens Product 8',
                'price': 1599,
                'oldPrice': 2999,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.womens9,
                'name': 'Womens Product 9',
                'price': 1099,
                'oldPrice': 1999,
                'discount': '45%Off',
                'rating': 4.5
              },
            ],
          ),
        );

      case gifts:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(
            title: 'Gifts',
            products: [
              {
                'image': AppAssets.gift1,
                'name': 'Gift Product 1',
                'price': 999,
                'oldPrice': 1799,
                'discount': '44%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.gift2,
                'name': 'Gift Product 2',
                'price': 1299,
                'oldPrice': 2499,
                'discount': '48%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.gift3,
                'name': 'Gift Product 3',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.gift4,
                'name': 'Gift Product 4',
                'price': 1499,
                'oldPrice': 2799,
                'discount': '46%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.gift5,
                'name': 'Gift Product 5',
                'price': 699,
                'oldPrice': 1299,
                'discount': '46%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.gift6,
                'name': 'Gift Product 6',
                'price': 1799,
                'oldPrice': 3299,
                'discount': '45%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.gift7,
                'name': 'Gift Product 7',
                'price': 899,
                'oldPrice': 1599,
                'discount': '44%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.gift8,
                'name': 'Gift Product 8',
                'price': 1199,
                'oldPrice': 2199,
                'discount': '45%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.gift9,
                'name': 'Gift Product 9',
                'price': 999,
                'oldPrice': 1799,
                'discount': '44%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.gift10,
                'name': 'Gift Product 10',
                'price': 1599,
                'oldPrice': 2999,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.gift11,
                'name': 'Gift Product 11',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.gift12,
                'name': 'Gift Product 12',
                'price': 1099,
                'oldPrice': 1999,
                'discount': '45%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.gift13,
                'name': 'Gift Product 13',
                'price': 899,
                'oldPrice': 1699,
                'discount': '47%Off',
                'rating': 4.5
              },
            ],
          ),
        );
      case summerSale:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(
            title: 'Hot Summer Sale 🔥',
            products: [
              {
                'image': AppAssets.summer1,
                'name': 'Summer Collection 1',
                'price': 999,
                'oldPrice': 1999,
                'discount': '50%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.summer2,
                'name': 'Summer Collection 2',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.summer3,
                'name': 'Summer Collection 3',
                'price': 1299,
                'oldPrice': 2499,
                'discount': '48%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.summer4,
                'name': 'Summer Collection 4',
                'price': 599,
                'oldPrice': 999,
                'discount': '40%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.summer5,
                'name': 'Summer Collection 5',
                'price': 1499,
                'oldPrice': 2999,
                'discount': '50%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.summer6,
                'name': 'Summer Collection 6',
                'price': 899,
                'oldPrice': 1799,
                'discount': '50%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.summer7,
                'name': 'Summer Collection 7',
                'price': 1199,
                'oldPrice': 2199,
                'discount': '45%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.summer8,
                'name': 'Summer Collection 8',
                'price': 699,
                'oldPrice': 1299,
                'discount': '46%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.summer9,
                'name': 'Summer Collection 9',
                'price': 1599,
                'oldPrice': 2999,
                'discount': '47%Off',
                'rating': 4.5
              },
            ],
          ),
        );
      case sponsoredScreen:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(
            title: 'Up to 50% Off 🛍️',
            products: [
              {
                'image': AppAssets.sponsored1,
                'name': 'Sponsored Product 1',
                'price': 999,
                'oldPrice': 1999,
                'discount': '50%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.sponsored2,
                'name': 'Sponsored Product 2',
                'price': 799,
                'oldPrice': 1499,
                'discount': '47%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.sponsored3,
                'name': 'Sponsored Product 3',
                'price': 1299,
                'oldPrice': 2499,
                'discount': '48%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.sponsored4,
                'name': 'Sponsored Product 4',
                'price': 599,
                'oldPrice': 999,
                'discount': '40%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.sponsored5,
                'name': 'Sponsored Product 5',
                'price': 1499,
                'oldPrice': 2999,
                'discount': '50%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.sponsored6,
                'name': 'Sponsored Product 6',
                'price': 899,
                'oldPrice': 1799,
                'discount': '50%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.sponsored7,
                'name': 'Sponsored Product 7',
                'price': 1199,
                'oldPrice': 2199,
                'discount': '45%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.sponsored8,
                'name': 'Sponsored Product 8',
                'price': 699,
                'oldPrice': 1299,
                'discount': '46%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.sponsored9,
                'name': 'Sponsored Product 9',
                'price': 1599,
                'oldPrice': 2999,
                'discount': '47%Off',
                'rating': 4.5
              },
              {
                'image': AppAssets.sponsored10,
                'name': 'Sponsored Product 10',
                'price': 999,
                'oldPrice': 1799,
                'discount': '44%Off',
                'rating': 4.0
              },
              {
                'image': AppAssets.sponsored11,
                'name': 'Sponsored Product 11',
                'price': 1299,
                'oldPrice': 2299,
                'discount': '43%Off',
                'rating': 4.5
              },
            ],
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found!')),
          ),
        );
    }
  }
}
