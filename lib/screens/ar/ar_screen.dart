import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  int _currentNavIndex = 0;
  int _selectedCategory = 0;
  int _selectedItem = 0;

  final List<String> _categories = [
    'T-Shirts',
    'Dresses',
    'Accessories',
  ];

  final List<List<Map<String, dynamic>>> _items = [
    // T-Shirts
    [
      {'name': 'Black Winter Hoodie', 'image': AppAssets.shop1, 'color': Colors.black},
      {'name': 'Mens Starry Shirt', 'image': AppAssets.shop2, 'color': Colors.blue},
      {'name': 'Large T-Shirt', 'image': AppAssets.largeTshirt, 'color': Colors.white},
    ],
    // Dresses
    [
      {'name': 'Black Dress', 'image': AppAssets.shop3, 'color': Colors.black},
      {'name': 'Pink Dress', 'image': AppAssets.shop4, 'color': Colors.pink},
      {'name': 'Flare Dress', 'image': AppAssets.shop5, 'color': Colors.orange},
    ],
    // Accessories
    [
      {'name': 'Red Bangles', 'image': AppAssets.fs6, 'color': Colors.red},
      {'name': 'Wedding Bangles', 'image': AppAssets.fs7, 'color': const Color(0xFFFFD700)},
      {'name': 'Women Purse', 'image': AppAssets.fs9, 'color': Colors.brown},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentItems = _items[_selectedCategory];
    final selectedProduct = currentItems[_selectedItem];

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
                  const Text(
                    'Virtual Try-On',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Virtual Mirror
                    Container(
                      margin: const EdgeInsets.all(16),
                      height: 350,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkCard
                            : AppColors.lightScaffoldBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Mirror background
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              color: isDark
                                  ? AppColors.darkCard
                                  : const Color(0xFFF0F0F0),
                            ),
                          ),

                          // Mannequin/Avatar
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Head
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFFFDBAC),
                                  border: Border.all(
                                    color: AppColors.lightBorder,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Iconsax.user,
                                  size: 36,
                                  color: AppColors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Body with product
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Body shape
                                  Container(
                                    width: 140,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFDBAC)
                                          .withValues(alpha: 0.3),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                  ),

                                  // Product overlay
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    child: Image.asset(
                                      selectedProduct['image'],
                                      width: 130,
                                      height: 170,
                                      fit: BoxFit.cover,
                                      opacity:
                                      const AlwaysStoppedAnimation(
                                          0.85),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // AR Label
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Iconsax.magic_star,
                                      color: AppColors.white, size: 12),
                                  SizedBox(width: 4),
                                  Text(
                                    'Virtual Try-On',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Product name
                          Positioned(
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                selectedProduct['name'],
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Category Selector
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: List.generate(
                          _categories.length,
                              (index) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = index;
                                  _selectedItem = 0;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8),
                                decoration: BoxDecoration(
                                  color: _selectedCategory == index
                                      ? AppColors.primary
                                      : isDark
                                      ? AppColors.darkCard
                                      : AppColors.lightScaffoldBg,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _categories[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedCategory == index
                                        ? AppColors.white
                                        : AppColors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Product Selector
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: currentItems.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = currentItems[index];
                          final isSelected = _selectedItem == index;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedItem = index),
                            child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.lightBorder,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Action Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                AppRoutes.productDetail,
                                arguments: {
                                  'name': selectedProduct['name'],
                                  'image': selectedProduct['image'],
                                  'price': 999,
                                  'oldPrice': 1999,
                                  'discount': '50%Off',
                                  'rating': 4.5,
                                  'reviews': 1234,
                                },
                              ),
                              icon: const Icon(
                                  Iconsax.shopping_cart,
                                  color: AppColors.white,
                                  size: 18),
                              label: const Text(
                                'Buy Now',
                                style:
                                TextStyle(color: AppColors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text('Screenshot saved!'),
                                    backgroundColor: AppColors.success,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: const Icon(Iconsax.camera,
                                  size: 18, color: AppColors.primary),
                              label: const Text(
                                'Screenshot',
                                style: TextStyle(
                                    color: AppColors.primary),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.primary),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
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