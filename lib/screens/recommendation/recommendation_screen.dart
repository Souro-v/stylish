import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/ai_recommendation_service.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() =>
      _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final AiRecommendationService _recommendationService =
  AiRecommendationService();
  List<Map<String, dynamic>> _recommendations = [];
  bool _isLoading = true;
  int _currentNavIndex = 0;

  // All products pool
  static const List<Map<String, dynamic>> _allProducts = [
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
      'desc': 'Solid Black Dress for Women',
      'price': 2000,
      'oldPrice': 3500,
      'discount': '43%Off',
      'rating': 4.5,
      'reviews': 523456,
    },
    {
      'image': AppAssets.shop4,
      'name': 'Pink Embroidered Dress',
      'desc': 'EARTHEN Rose Pink Embroidered Tiered Max',
      'price': 1900,
      'oldPrice': 3000,
      'discount': '37%Off',
      'rating': 4.5,
      'reviews': 45678,
    },
    {
      'image': AppAssets.shop5,
      'name': 'Flare Dress',
      'desc': 'Antheaa Black & Rust Orange Floral Print',
      'price': 1990,
      'oldPrice': 3500,
      'discount': '43%Off',
      'rating': 4.0,
      'reviews': 335566,
    },
    {
      'image': AppAssets.shop6,
      'name': 'Denim Dress',
      'desc': 'Blue cotton denim dress',
      'price': 999,
      'oldPrice': 1999,
      'discount': '50%Off',
      'rating': 4.0,
      'reviews': 27344,
    },
    {
      'image': AppAssets.shop7,
      'name': 'Jordan Stay',
      'desc': 'The classic Air Jordan 12',
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
      'image': AppAssets.blendBlazer,
      'name': 'Blend Blazer',
      'desc': 'Premium blend blazer',
      'price': 4999,
      'oldPrice': 6499,
      'discount': '23%Off',
      'rating': 4.5,
      'reviews': 124,
    },
    {
      'image': AppAssets.hotCasual,
      'name': 'Hot Casual',
      'desc': 'Trendy casual wear',
      'price': 1599,
      'oldPrice': 2299,
      'discount': '30%Off',
      'rating': 4.0,
      'reviews': 78,
    },
    {
      'image': AppAssets.summerHot,
      'name': 'Summer Hot Dress',
      'desc': 'Perfect summer dress',
      'price': 1799,
      'oldPrice': 2799,
      'discount': '36%Off',
      'rating': 4.0,
      'reviews': 92,
    },
    {
      'image': AppAssets.largeTshirt,
      'name': 'Large T-Shirt',
      'desc': 'Comfortable large t-shirt',
      'price': 899,
      'oldPrice': 1499,
      'discount': '40%Off',
      'rating': 4.0,
      'reviews': 234,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    final recommendations =
    await _recommendationService.getRecommendations(_allProducts);
    setState(() {
      _recommendations = recommendations;
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
                    'Recommended For You',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() => _isLoading = true);
                      _loadRecommendations();
                    },
                    child: const Icon(Iconsax.refresh,
                        color: AppColors.primary),
                  ),
                ],
              ),
            ),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Based on your activity',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Products
            Expanded(
              child: _isLoading
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Finding best products for you...',
                      style: TextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
              )
                  : Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: _recommendations.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) {
                    final product = _recommendations[index];
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
                                        '${product['rating']}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
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
                                            padding:
                                            const EdgeInsets
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