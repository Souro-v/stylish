import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  int _currentNavIndex = 0;

  static const List<Map<String, dynamic>> _products = [
    {
      'image': AppAssets.shop1,
      'name': 'Black Winter Hoodie',
      'desc': 'Autumn And Winter Casual cotton-padded jacket',
      'price': 499,
      'oldPrice': 999,
      'discount': '50%Off',
      'rating': 4.0,
      'reviews': 6890,
    },
    {
      'image': AppAssets.shop2,
      'name': 'Mens Starry Shirt',
      'desc': 'Mens Starry Sky Printed Shirt 100% Cotton Fabric',
      'price': 399,
      'oldPrice': 799,
      'discount': '50%Off',
      'rating': 4.5,
      'reviews': 152344,
    },
    {
      'image': AppAssets.shop3,
      'name': 'Black Dress',
      'desc': 'Solid Black Dress for Women, Sexy Chain Shorts Ladi...',
      'price': 2000,
      'oldPrice': 3500,
      'discount': '43%Off',
      'rating': 4.5,
      'reviews': 523456,
    },
    {
      'image': AppAssets.shop4,
      'name': 'Pink Embroidered Dress',
      'desc': 'EARTHEN Rose Pink Embroidered Tiered Max...',
      'price': 1900,
      'oldPrice': 3000,
      'discount': '37%Off',
      'rating': 4.5,
      'reviews': 45678,
    },
    {
      'image': AppAssets.shop5,
      'name': 'Flare Dress',
      'desc': 'Antheaa Black & Rust Orange Floral Print Tiered Midi F...',
      'price': 1990,
      'oldPrice': 3500,
      'discount': '43%Off',
      'rating': 4.0,
      'reviews': 335566,
    },
    {
      'image': AppAssets.shop6,
      'name': 'Denim Dress',
      'desc': 'Blue cotton denim dress Look 2 Printed cotton dr...',
      'price': 999,
      'oldPrice': 1999,
      'discount': '50%Off',
      'rating': 4.0,
      'reviews': 27344,
    },
    {
      'image': AppAssets.shop7,
      'name': 'Jordan Stay',
      'desc': 'The classic Air Jordan 12 to create a shoe that\'s fres...',
      'price': 4999,
      'oldPrice': 7999,
      'discount': '38%Off',
      'rating': 3.5,
      'reviews': 1023456,
    },
    {
      'image': AppAssets.shop8,
      'name': 'Nike Sneakers',
      'desc': 'Nike Air Jordan Retro 1 Low Mystic Black',
      'price': 1900,
      'oldPrice': 2999,
      'discount': '37%Off',
      'rating': 4.5,
      'reviews': 46890,
    },
    {
      'image': AppAssets.shop9,
      'name': 'Sony PS4',
      'desc': 'Sony PS4 Console, 1TB Slim with 3 Games: Gran Turis...',
      'price': 1999,
      'oldPrice': 3999,
      'discount': '50%Off',
      'rating': 4.0,
      'reviews': 835566,
    },
    {
      'image': AppAssets.shop10,
      'name': 'Black Jacket 12...',
      'desc': 'This warm and comfortable jacket is great for learnin...',
      'price': 2999,
      'oldPrice': 4999,
      'discount': '40%Off',
      'rating': 4.0,
      'reviews': 223569,
    },
    {
      'image': AppAssets.shop11,
      'name': 'D7200 Digital Camera',
      'desc': 'D7200 Digital Camera (Nikon) In New Area...',
      'price': 26999,
      'oldPrice': 45999,
      'discount': '41%Off',
      'rating': 4.5,
      'reviews': 67456,
    },
    {
      'image': AppAssets.shop12,
      'name': 'Men\'s Formal Shoes',
      'desc': 'George Walker Derby Brown Formal Shoes',
      'price': 999,
      'oldPrice': 1999,
      'discount': '50%Off',
      'rating': 5.0,
      'reviews': 1348678,
    },
  ];

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
                  const Icon(Iconsax.menu, size: 24),
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

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.search),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkCard
                        : AppColors.lightScaffoldBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Iconsax.search_normal, color: AppColors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Search any Product...',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Iconsax.microphone, color: AppColors.grey),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Count + Sort + Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '52,082+ Items',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Iconsax.sort, size: 16),
                        label: const Text('Sort'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.grey,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Iconsax.filter, size: 16),
                        label: const Text('Filter'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Product Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: _products.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.52,
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
                              color:
                              AppColors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image + Wishlist
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
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Consumer<WishlistProvider>(
                                    builder: (context, wishlist, _) {
                                      final isWishlisted = wishlist
                                          .isWishlisted(product['name']);
                                      return GestureDetector(
                                        onTap: () => wishlist
                                            .toggleWishlist(product),
                                        child: Container(
                                          padding:
                                          const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.black
                                                    .withValues(alpha: 0.1),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            isWishlisted
                                                ? Icons.favorite
                                                : Icons.favorite_border,
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
                                    maxLines: 2,
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
                                          decoration:
                                          TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 13),
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

                                  // Add to Cart Button
                                  Consumer<CartProvider>(
                                    builder: (context, cart, _) {
                                      final isInCart = cart
                                          .isInCart(product['name']);
                                      return SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (isInCart) {
                                              Navigator.pushNamed(context,
                                                  AppRoutes.placeOrder);
                                            } else {
                                              cart.addToCart(product);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Added to cart!'),
                                                  backgroundColor:
                                                  AppColors.primary,
                                                  duration: Duration(
                                                      seconds: 1),
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            AppColors.primary,
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(8),
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