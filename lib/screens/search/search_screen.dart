import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/star_rating.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  String _query = '';

  final List<String> _recentSearches = [
    'Nike Sneakers',
    'Women Kurta',
    'Smart Watch',
    'Black Jacket',
  ];

  final List<String> _popularSearches = [
    'Fashion',
    'Shoes',
    'Watches',
    'Bags',
    'Electronics',
    'Dresses',
  ];

  final List<Map<String, dynamic>> _allProducts = [
    {
      'image': AppAssets.shop1,
      'name': 'Black Winter Hoodie',
      'price': 499,
      'rating': 4.0,
    },
    {
      'image': AppAssets.shop2,
      'name': 'Mens Starry Shirt',
      'price': 399,
      'rating': 4.5,
    },
    {
      'image': AppAssets.shop3,
      'name': 'Black Dress',
      'price': 2000,
      'rating': 4.5,
    },
    {
      'image': AppAssets.shop4,
      'name': 'Pink Embroidered Dress',
      'price': 1900,
      'rating': 4.5,
    },
    {
      'image': AppAssets.shop5,
      'name': 'Flare Dress',
      'price': 1990,
      'rating': 4.0,
    },
    {
      'image': AppAssets.shop6,
      'name': 'Denim Dress',
      'price': 1500,
      'rating': 4.0,
    },
    {
      'image': AppAssets.shop7,
      'name': 'Jordan Stay',
      'price': 4999,
      'rating': 3.5,
    },
    {
      'image': AppAssets.shop8,
      'name': 'Nike Sneakers',
      'price': 1900,
      'rating': 4.5,
    },
    {
      'image': AppAssets.shop9,
      'name': 'Sony PS4',
      'price': 1999,
      'rating': 4.0,
    },
    {
      'image': AppAssets.shop10,
      'name': 'Black Jacket',
      'price': 2999,
      'rating': 4.0,
    },
    {
      'image': AppAssets.shop11,
      'name': 'D7200 Digital Camera',
      'price': 26999,
      'rating': 4.5,
    },
    {
      'image': AppAssets.shop12,
      'name': 'Men\'s Formal Shoes',
      'price': 999,
      'rating': 5.0,
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    if (_query.isEmpty) return [];
    return _allProducts
        .where((p) =>
        p['name'].toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCard
                      : AppColors.lightScaffoldBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.search_normal,
                        color: AppColors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Search any Product...',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _query = value;
                            _isSearching = value.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    if (_isSearching)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() {
                            _query = '';
                            _isSearching = false;
                          });
                        },
                        child: const Icon(Icons.close,
                            color: AppColors.grey, size: 20),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Content
              Expanded(
                child: _isSearching
                    ? _buildSearchResults(isDark)
                    : _buildDefaultContent(isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Default Content (before search)
  Widget _buildDefaultContent(bool isDark) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => _recentSearches.clear());
                },
                child: const Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Recent List
          ..._recentSearches.map((search) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Iconsax.clock,
                  color: AppColors.grey, size: 20),
              title: Text(
                search,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(Icons.north_west,
                  color: AppColors.grey, size: 16),
              onTap: () {
                _searchController.text = search;
                setState(() {
                  _query = search;
                  _isSearching = true;
                });
              },
            );
          }),
          const SizedBox(height: 20),

          // Popular Searches
          const Text(
            'Popular Searches',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _popularSearches.map((search) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = search;
                  setState(() {
                    _query = search;
                    _isSearching = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkCard
                        : AppColors.lightScaffoldBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.lightBorder),
                  ),
                  child: Text(
                    search,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Search Results
  Widget _buildSearchResults(bool isDark) {
    final results = _filteredProducts;

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.search_normal,
                size: 60,
                color: AppColors.grey.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            const Text(
              'No products found!',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      itemCount: results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final product = results[index];
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
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product['image'],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
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
                          fontWeight: FontWeight.w500,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}