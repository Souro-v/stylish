import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class FlashSaleScreen extends StatefulWidget {
  const FlashSaleScreen({super.key});

  @override
  State<FlashSaleScreen> createState() => _FlashSaleScreenState();
}

class _FlashSaleScreenState extends State<FlashSaleScreen> {
  int _currentNavIndex = 0;
  late Timer _timer;
  int _hours = 5;
  int _minutes = 59;
  int _seconds = 59;

  static const List<Map<String, dynamic>> _products = [
    {
      'image': AppAssets.fs1,
      'name': 'T-Shirt Collection 1',
      'desc': 'Premium quality t-shirt',
      'price': 299,
      'oldPrice': 799,
      'discount': '63%Off',
      'rating': 4.5,
      'reviews': 1234,
    },
    {
      'image': AppAssets.fs2,
      'name': 'T-Shirt Collection 2',
      'desc': 'Stylish casual t-shirt',
      'price': 349,
      'oldPrice': 899,
      'discount': '61%Off',
      'rating': 4.0,
      'reviews': 987,
    },
    {
      'image': AppAssets.fs3,
      'name': 'T-Shirt Collection 3',
      'desc': 'Comfortable cotton t-shirt',
      'price': 279,
      'oldPrice': 699,
      'discount': '60%Off',
      'rating': 4.5,
      'reviews': 2341,
    },
    {
      'image': AppAssets.fs4,
      'name': 'Red Wedding Lehenga',
      'desc': 'Beautiful red wedding lehenga',
      'price': 2999,
      'oldPrice': 8999,
      'discount': '67%Off',
      'rating': 4.5,
      'reviews': 456,
    },
    {
      'image': AppAssets.fs5,
      'name': 'Light Pink Lehenga',
      'desc': 'Premium light pink wedding lehenga',
      'price': 3499,
      'oldPrice': 9999,
      'discount': '65%Off',
      'rating': 5.0,
      'reviews': 321,
    },
    {
      'image': AppAssets.fs6,
      'name': 'Red & Gold Bangles',
      'desc': 'Beautiful red and gold bangles',
      'price': 499,
      'oldPrice': 1299,
      'discount': '62%Off',
      'rating': 4.5,
      'reviews': 876,
    },
    {
      'image': AppAssets.fs7,
      'name': 'Wedding Bangles',
      'desc': 'Traditional wedding bangles',
      'price': 599,
      'oldPrice': 1599,
      'discount': '63%Off',
      'rating': 4.0,
      'reviews': 654,
    },
    {
      'image': AppAssets.fs8,
      'name': 'Classical Modern Bangles',
      'desc': 'Classical modern style bangles',
      'price': 449,
      'oldPrice': 1199,
      'discount': '63%Off',
      'rating': 4.5,
      'reviews': 543,
    },
    {
      'image': AppAssets.fs9,
      'name': 'Women Purse 1',
      'desc': 'Stylish women purse',
      'price': 799,
      'oldPrice': 1999,
      'discount': '60%Off',
      'rating': 4.0,
      'reviews': 1234,
    },
    {
      'image': AppAssets.fs10,
      'name': 'Women Purse 2',
      'desc': 'Premium women purse',
      'price': 899,
      'oldPrice': 2299,
      'discount': '61%Off',
      'rating': 4.5,
      'reviews': 987,
    },
    {
      'image': AppAssets.fs11,
      'name': 'Men Wallet 1',
      'desc': 'Genuine leather men wallet',
      'price': 599,
      'oldPrice': 1499,
      'discount': '60%Off',
      'rating': 4.5,
      'reviews': 2345,
    },
    {
      'image': AppAssets.fs12,
      'name': 'Men Wallet 2',
      'desc': 'Premium men wallet',
      'price': 699,
      'oldPrice': 1799,
      'discount': '61%Off',
      'rating': 4.0,
      'reviews': 1876,
    },
    {
      'image': AppAssets.fs13,
      'name': 'Men Wallet 3',
      'desc': 'Classic men wallet',
      'price': 499,
      'oldPrice': 1299,
      'discount': '62%Off',
      'rating': 4.5,
      'reviews': 3456,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else if (_minutes > 0) {
          _minutes--;
          _seconds = 59;
        } else if (_hours > 0) {
          _hours--;
          _minutes = 59;
          _seconds = 59;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  Row(
                    children: [
                      Image.asset(AppAssets.logo, width: 32, height: 32),
                      const SizedBox(width: 6),
                      const Text(
                        'Stylish',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.profile),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.lightBorder,
                      child: Icon(Iconsax.user, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Banner
                    Image.asset(
                      AppAssets.flashBanner,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),

                    // Timer
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      color: AppColors.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.flash,
                              color: AppColors.white, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Flash Sale Ends In: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          _TimerBox(value: _hours),
                          const Text(' : ',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          _TimerBox(value: _minutes),
                          const Text(' : ',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          _TimerBox(value: _seconds),
                        ],
                      ),
                    ),

                    // Product Grid
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _products.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.58,
                        ),
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.productDetail,
                              arguments: product,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkCard
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black
                                        .withValues(alpha: 0.06),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // Image + Wishlist + Discount
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        const BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                        child: Image.asset(
                                          product['image'],
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Wishlist
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Consumer<WishlistProvider>(
                                          builder:
                                              (context, wishlist, _) {
                                            final isWishlisted = wishlist
                                                .isWishlisted(
                                                product['name']);
                                            return GestureDetector(
                                              onTap: () => wishlist
                                                  .toggleWishlist(product),
                                              child: Container(
                                                padding:
                                                const EdgeInsets.all(
                                                    6),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors
                                                          .black
                                                          .withValues(
                                                          alpha: 0.1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(
                                                  isWishlisted
                                                      ? Icons.favorite
                                                      : Icons
                                                      .favorite_border,
                                                  size: 16,
                                                  color: isWishlisted
                                                      ? AppColors.primary
                                                      : AppColors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Discount Badge
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius:
                                            BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            product['discount'],
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Details
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          product['desc'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              '₹${product['price']}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '₹${product['oldPrice']}',
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: AppColors.grey,
                                                decoration: TextDecoration
                                                    .lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star,
                                                color: Colors.amber,
                                                size: 13),
                                            const SizedBox(width: 2),
                                            Text(
                                              '${product['rating']} (${product['reviews']})',
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: AppColors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),

                                        // Add to Cart
                                        Consumer<CartProvider>(
                                          builder: (context, cart, _) {
                                            final isInCart = cart
                                                .isInCart(product['name']);
                                            return SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (isInCart) {
                                                    Navigator.pushNamed(
                                                        context,
                                                        AppRoutes
                                                            .placeOrder);
                                                  } else {
                                                    cart.addToCart(product);
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Added to cart!'),
                                                        backgroundColor:
                                                        AppColors
                                                            .primary,
                                                        duration: Duration(
                                                            seconds: 1),
                                                      ),
                                                    );
                                                  }
                                                },
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  AppColors.primary,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 6),
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(8),
                                                  ),
                                                ),
                                                child: Text(
                                                  isInCart
                                                      ? 'Go to cart'
                                                      : 'Add to cart',
                                                  style: const TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() => _currentNavIndex = index);
          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
          if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.wishlist);
          }
          if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.placeOrder);
          }
          if (index == 3) {
            Navigator.pushNamed(context, AppRoutes.search);
          }
          if (index == 4) {
            Navigator.pushNamed(context, AppRoutes.profile);
          }
        },
      ),
    );
  }
}

class _TimerBox extends StatelessWidget {
  final int value;

  const _TimerBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}