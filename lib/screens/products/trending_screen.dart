
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../../widgets/common/star_rating.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  int _currentNavIndex = 1;

  static const List<Map<String, dynamic>> _products = [
    {
      'image': AppAssets.shop1,
      'name': 'Black Winter...',
      'desc': 'Autumn And Winter Casual cotton-padded jacket...',
      'price': 499,
      'rating': 4.0,
      'reviews': 6890,
    },
    {
      'image': AppAssets.shop2,
      'name': 'Mens Starry',
      'desc': 'Mens Starry Sky Printed Shirt 100% Cotton Fabric',
      'price': 399,
      'rating': 4.5,
      'reviews': 152344,
    },
    {
      'image': AppAssets.shop3,
      'name': 'Black Dress',
      'desc': 'Solid Black Dress for Women, Sexy Chain Shorts Ladi...',
      'price': 2000,
      'rating': 4.5,
      'reviews': 523456,
    },
    {
      'image': AppAssets.shop4,
      'name': 'Pink Embroide...',
      'desc': 'EARTHEN Rose Pink Embroidered Tiered Max...',
      'price': 1900,
      'rating': 4.5,
      'reviews': 45678,
    },
    {
      'image': AppAssets.shop5,
      'name': 'Flare Dress',
      'desc': 'Antheaa Black & Rust Orange Floral Print Tiered Midi F...',
      'price': 1990,
      'rating': 4.0,
      'reviews': 335566,
    },
    {
      'image': AppAssets.shop6,
      'name': 'denim dress',
      'desc': 'Blue cotton denim dress',
      'price': 1500,
      'rating': 4.0,
      'reviews': 12000,
    },
    {
      'image': AppAssets.shop7,
      'name': 'Jordan Stay',
      'desc': 'The classic Air Jordan 12 to create a shoe that\'s fres...',
      'price': 4999,
      'rating': 3.5,
      'reviews': 10234,
    },
    {
      'image': AppAssets.shop8,
      'name': 'Nike Sneakers',
      'desc': 'Nike Air Jordan Retro 1 Low Mystic Black',
      'price': 1900,
      'rating': 4.5,
      'reviews': 46890,
    },
    {
      'image': AppAssets.shop9,
      'name': 'Sony PS4',
      'desc': 'Sony PS4 Console, 1TB Slim with 3 Games: Gran Turis...',
      'price': 1999,
      'rating': 4.0,
      'reviews': 835566,
    },
    {
      'image': AppAssets.shop10,
      'name': 'Black Jacket 12...',
      'desc': 'This warm and comfortable jacket is great for learnin...',
      'price': 2999,
      'rating': 4.0,
      'reviews': 223569,
    },
    {
      'image': AppAssets.shop11,
      'name': 'D7200 Digital C...',
      'desc': 'D7200 Digital Camera (Nikon) In New Area...',
      'price': 26999,
      'rating': 4.5,
      'reviews': 67456,
    },
    {
      'image': AppAssets.shop12,
      'name': 'men\'s & boys s...',
      'desc': 'George Walker Derby Brown Formal Shoes',
      'price': 999,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.lightBorder,
                    child: Icon(Iconsax.user, size: 20),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          context, AppRoutes.productDetail),
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
                            // Image
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.asset(
                                product['image'],
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Details
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
                                  Text(
                                    '₹${product['price']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  StarRating(
                                    rating: product['rating'],
                                    size: 12,
                                    showRatingText: true,
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
        },
      ),
    );
  }
}