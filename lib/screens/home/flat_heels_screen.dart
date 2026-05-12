import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class FlatHeelsScreen extends StatefulWidget {
  const FlatHeelsScreen({super.key});

  @override
  State<FlatHeelsScreen> createState() => _FlatHeelsScreenState();
}

class _FlatHeelsScreenState extends State<FlatHeelsScreen> {
  int _currentNavIndex = 0;

  static const List<Map<String, dynamic>> _products = [
    {
      'image': AppAssets.fh1,
      'name': 'Flat & Heels 1',
      'price': 1299,
      'oldPrice': 2499,
      'discount': '48%Off',
      'rating': 4.5
    },
    {
      'image': AppAssets.fh2,
      'name': 'Flat & Heels 2',
      'price': 999,
      'oldPrice': 1999,
      'discount': '50%Off',
      'rating': 4.0
    },
    {
      'image': AppAssets.fh3,
      'name': 'Flat & Heels 3',
      'price': 1499,
      'oldPrice': 2999,
      'discount': '50%Off',
      'rating': 4.5
    },
    {
      'image': AppAssets.fh4,
      'name': 'Flat & Heels 4',
      'price': 799,
      'oldPrice': 1499,
      'discount': '47%Off',
      'rating': 4.0
    },
    {
      'image': AppAssets.fh5,
      'name': 'Flat & Heels 5',
      'price': 1799,
      'oldPrice': 3499,
      'discount': '49%Off',
      'rating': 4.5
    },
    {
      'image': AppAssets.fh6,
      'name': 'Flat & Heels 6',
      'price': 899,
      'oldPrice': 1799,
      'discount': '50%Off',
      'rating': 4.0
    },
    {
      'image': AppAssets.fh7,
      'name': 'Flat & Heels 7',
      'price': 1199,
      'oldPrice': 2199,
      'discount': '45%Off',
      'rating': 4.5
    },
    {
      'image': AppAssets.fh8,
      'name': 'Flat & Heels 8',
      'price': 699,
      'oldPrice': 1299,
      'discount': '46%Off',
      'rating': 4.0
    },
    {
      'image': AppAssets.fh9,
      'name': 'Flat & Heels 9',
      'price': 1599,
      'oldPrice': 2999,
      'discount': '47%Off',
      'rating': 4.5
    },
    {
      'image': AppAssets.fh10,
      'name': 'Flat & Heels 10',
      'price': 999,
      'oldPrice': 1999,
      'discount': '50%Off',
      'rating': 4.0
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Flat and Heels',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Product Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.productDetail,
                          arguments: product),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCard : AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.asset(
                                    product['image'],
                                    height: 160,
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
                                        onTap: () =>
                                            wishlist.toggleWishlist(product),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
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
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(4),
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
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        '₹${product['price']}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '₹${product['oldPrice']}',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 13),
                                      const SizedBox(width: 2),
                                      Text('${product['rating']}',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.grey)),
                                    ],
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
          if (index == 1) Navigator.pushNamed(context, AppRoutes.trending);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.placeOrder);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.search);
          if (index == 4) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),
    );
  }
}
