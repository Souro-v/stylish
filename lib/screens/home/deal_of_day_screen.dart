import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class DealOfDayScreen extends StatefulWidget {
  const DealOfDayScreen({super.key});

  @override
  State<DealOfDayScreen> createState() => _DealOfDayScreenState();
}

class _DealOfDayScreenState extends State<DealOfDayScreen> {
  int _currentNavIndex = 0;

  static const List<Map<String, dynamic>> _products = [
    {
      'image': AppAssets.deal1,
      'name': 'Women Printed Kurta',
      'desc': 'Neque porro quisquam est qui dolorem ipsum quia',
      'price': 1500,
      'oldPrice': 2500,
      'discount': '40%Off',
      'rating': 4.5,
    },
    {
      'image': AppAssets.deal2,
      'name': 'HRX by Hrithik Roshan',
      'desc': 'Neque porro quisquam est qui dolorem ipsum quia',
      'price': 2499,
      'oldPrice': 4999,
      'discount': '50%Off',
      'rating': 4.5,
    },
    {
      'image': AppAssets.deal3,
      'name': 'Philips BHH880/10',
      'desc': 'Hair Straightening Brush With Keratin Infused Bristles (Black).',
      'price': 999,
      'oldPrice': 1999,
      'discount': '50%Off',
      'rating': 4.5,
    },
    {
      'image': AppAssets.deal4,
      'name': 'TITAN Men Watch- 1806N',
      'desc': 'This Titan watch in Black color is I wanted to buy for a long time',
      'price': 1500,
      'oldPrice': 3500,
      'discount': '60%Off',
      'rating': 4.0,
    },
    {
      'image': AppAssets.dod1,
      'name': 'Deal Product 5',
      'desc': 'Amazing deal at the best price',
      'price': 1200,
      'oldPrice': 2000,
      'discount': '40%Off',
      'rating': 4.0,
    },
    {
      'image': AppAssets.dod2,
      'name': 'Deal Product 6',
      'desc': 'Amazing deal at the best price',
      'price': 800,
      'oldPrice': 1500,
      'discount': '47%Off',
      'rating': 4.5,
    },
    {
      'image': AppAssets.dod3,
      'name': 'Deal Product 7',
      'desc': 'Amazing deal at the best price',
      'price': 2000,
      'oldPrice': 3500,
      'discount': '43%Off',
      'rating': 4.0,
    },
    {
      'image': AppAssets.dod4,
      'name': 'Deal Product 8',
      'desc': 'Amazing deal at the best price',
      'price': 1800,
      'oldPrice': 3000,
      'discount': '40%Off',
      'rating': 4.5,
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

            // Title + Timer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Iconsax.clock, size: 14, color: AppColors.white),
                    SizedBox(width: 6),
                    Text(
                      'Deal of the Day',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '22h 55m 20s remaining',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
                    ),
                  ],
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
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
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
                                // Discount Badge
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
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
                                        '${product['rating']}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.grey,
                                        ),
                                      ),
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