import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class SimilarProductsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const SimilarProductsScreen({super.key, required this.product});

  @override
  State<SimilarProductsScreen> createState() =>
      _SimilarProductsScreenState();
}

class _SimilarProductsScreenState
    extends State<SimilarProductsScreen> {
  int _currentNavIndex = 0;
  String _sortBy = 'Popularity';
  String _filterBy = 'All';

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
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> products =
    List.from(_allProducts);

    // Exclude current product
    products.removeWhere(
            (p) => p['name'] == widget.product['name']);

    // Filter
    if (_filterBy == 'Under ₹500') {
      products = products
          .where((p) => (p['price'] as int) < 500)
          .toList();
    } else if (_filterBy == '₹500-₹2000') {
      products = products
          .where((p) =>
      (p['price'] as int) >= 500 &&
          (p['price'] as int) <= 2000)
          .toList();
    } else if (_filterBy == 'Above ₹2000') {
      products = products
          .where((p) => (p['price'] as int) > 2000)
          .toList();
    }

    // Sort
    if (_sortBy == 'Price: Low to High') {
      products.sort(
              (a, b) => (a['price'] as int).compareTo(b['price'] as int));
    } else if (_sortBy == 'Price: High to Low') {
      products.sort(
              (a, b) => (b['price'] as int).compareTo(a['price'] as int));
    } else if (_sortBy == 'Rating') {
      products.sort((a, b) =>
          (b['rating'] as double).compareTo(a['rating'] as double));
    } else if (_sortBy == 'Discount') {
      products.sort((a, b) {
        final aDiscount = (a['oldPrice'] as int) - (a['price'] as int);
        final bDiscount = (b['oldPrice'] as int) - (b['price'] as int);
        return bDiscount.compareTo(aDiscount);
      });
    }

    return products;
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sort By',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...['Popularity', 'Price: Low to High',
              'Price: High to Low', 'Rating', 'Discount']
                .map((sort) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(sort),
              trailing: _sortBy == sort
                  ? const Icon(Icons.check,
                  color: AppColors.primary)
                  : null,
              onTap: () {
                setState(() => _sortBy = sort);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Filter By Price',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...['All', 'Under ₹500', '₹500-₹2000',
              'Above ₹2000']
                .map((filter) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(filter),
              trailing: _filterBy == filter
                  ? const Icon(Icons.check,
                  color: AppColors.primary)
                  : null,
              onTap: () {
                setState(() => _filterBy = filter);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final products = _filteredProducts;

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
                    'Similar Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            // Count + Sort + Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${products.length} Items',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: _showSortBottomSheet,
                        icon: const Icon(Iconsax.sort, size: 16),
                        label: const Text('Sort'),
                        style: TextButton.styleFrom(
                          foregroundColor: _sortBy != 'Popularity'
                              ? AppColors.primary
                              : AppColors.grey,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _showFilterBottomSheet,
                        icon: const Icon(Iconsax.filter, size: 16),
                        label: const Text('Filter'),
                        style: TextButton.styleFrom(
                          foregroundColor: _filterBy != 'All'
                              ? AppColors.primary
                              : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Products Grid
            Expanded(
              child: products.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.box,
                        size: 60, color: AppColors.grey),
                    SizedBox(height: 12),
                    Text('No products found',
                        style:
                        TextStyle(color: AppColors.grey)),
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
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
                          borderRadius:
                          BorderRadius.circular(12),
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
                                  child:
                                  Consumer<WishlistProvider>(
                                    builder:
                                        (context, wishlist, _) {
                                      final isWishlisted =
                                      wishlist.isWishlisted(
                                          product['name']);
                                      return GestureDetector(
                                        onTap: () => wishlist
                                            .toggleWishlist(
                                            product),
                                        child: Container(
                                          padding:
                                          const EdgeInsets
                                              .all(6),
                                          decoration:
                                          BoxDecoration(
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
                                    overflow:
                                    TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product['desc'],
                                    maxLines: 1,
                                    overflow:
                                    TextOverflow.ellipsis,
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
                                          fontWeight:
                                          FontWeight.bold,
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
                                              cart.addToCart(
                                                  product);
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