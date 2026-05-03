import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class NewArrivalsScreen extends StatefulWidget {
  const NewArrivalsScreen({super.key});

  @override
  State<NewArrivalsScreen> createState() => _NewArrivalsScreenState();
}

class _NewArrivalsScreenState extends State<NewArrivalsScreen> {
  int _currentNavIndex = 0;

  static const List<Map<String, dynamic>> _products = [
    {
      'image': AppAssets.blendBlazer,
      'name': 'Blend Blazer',
      'price': 4999,
      'oldPrice': 6499,
      'rating': 4.5,
      'reviews': 124,
    },
    {
      'image': AppAssets.blendBlazer1,
      'name': 'Blend Blazer Classic',
      'price': 3299,
      'oldPrice': 4299,
      'rating': 4.5,
      'reviews': 89,
    },
    {
      'image': AppAssets.hotCasual1,
      'name': 'Hot Casual Dress',
      'price': 1899,
      'oldPrice': 2499,
      'rating': 4.0,
      'reviews': 56,
    },
    {
      'image': AppAssets.blackBlend,
      'name': 'Black Blend Dress',
      'price': 2799,
      'oldPrice': 3999,
      'rating': 5.0,
      'reviews': 210,
    },
    {
      'image': AppAssets.hotCasual,
      'name': 'Hot Casual',
      'price': 1599,
      'oldPrice': 2299,
      'rating': 4.0,
      'reviews': 78,
    },
    {
      'image': AppAssets.summerHot1,
      'name': 'Summer Hot Dress',
      'price': 2199,
      'oldPrice': 3499,
      'rating': 4.5,
      'reviews': 143,
    },
    {
      'image': AppAssets.summerHot,
      'name': 'Summer Hot',
      'price': 1799,
      'oldPrice': 2799,
      'rating': 4.0,
      'reviews': 92,
    },
    {
      'image': AppAssets.summerHoliday2,
      'name': 'Summer Holiday',
      'price': 2499,
      'oldPrice': 3999,
      'rating': 4.5,
      'reviews': 167,
    },
    {
      'image': AppAssets.largeTshirt,
      'name': 'Large T-Shirt',
      'price': 899,
      'oldPrice': 1499,
      'rating': 4.0,
      'reviews': 234,
    },
    {
      'image': AppAssets.largeTshirt1,
      'name': 'Large T-Shirt Premium',
      'price': 1199,
      'oldPrice': 1899,
      'rating': 4.5,
      'reviews': 189,
    },
    {
      'image': AppAssets.boysGlass1,
      'name': 'Boys Sunglasses',
      'price': 599,
      'oldPrice': 999,
      'rating': 4.0,
      'reviews': 312,
    },
    {
      'image': AppAssets.boysGlass2,
      'name': 'Boys Glass Premium',
      'price': 799,
      'oldPrice': 1299,
      'rating': 4.5,
      'reviews': 98,
    },
    {
      'image': AppAssets.uniGlass1,
      'name': 'Uni Round Glass',
      'price': 499,
      'oldPrice': 899,
      'rating': 4.0,
      'reviews': 445,
    },
    {
      'image': AppAssets.summerHoliday,
      'name': 'Summer Holiday Dress',
      'price': 2999,
      'oldPrice': 4499,
      'rating': 4.5,
      'reviews': 267,
    },
    {
      'image': AppAssets.summerHoliday1,
      'name': 'Summer Holiday Casual',
      'price': 2299,
      'oldPrice': 3499,
      'rating': 4.0,
      'reviews': 183,
    },
  ];

  final List<bool> _wishlisted = List.generate(15, (_) => false);

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
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.lightBorder,
                    child: Icon(Iconsax.user, size: 20),
                  ),
                ],
              ),
            ),

            // Title
           const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Arrivals',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Summer' 25 Collections",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
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
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.productDetail),
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
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    product['image'],
                                    height: 170,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _wishlisted[index] =
                                            !_wishlisted[index];
                                      });
                                    },
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
                                        _wishlisted[index]
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 16,
                                        color: _wishlisted[index]
                                            ? AppColors.primary
                                            : AppColors.grey,
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
                                      fontWeight: FontWeight.w600,
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
                                      const SizedBox(width: 6),
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
                                  const SizedBox(height: 4),
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
            Navigator.pushNamed(context, AppRoutes.trending);
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
