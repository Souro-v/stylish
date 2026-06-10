import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/recently_viewed_service.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  final RecentlyViewedService _service = RecentlyViewedService();
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _service.getRecentlyViewed();
    setState(() {
      _products = products;
      _isLoading = false;
    });
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  const Text(
                    'Recently Viewed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _service.clearRecentlyViewed();
                      setState(() => _products = []);
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: _isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary))
                  : _products.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.eye,
                                size: 80,
                                color: AppColors.grey.withValues(alpha: 0.4),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'No recently viewed products',
                                style: TextStyle(color: AppColors.grey),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GridView.builder(
                            itemCount: _products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.65,
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
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                final isWishlisted =
                                                    wishlist.isWishlisted(
                                                        product['name']);
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
                                            const SizedBox(height: 4),
                                            Text(
                                              '₹${product['price']}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary,
                                              ),
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
