import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/analytics_service.dart';
import '../../core/services/recently_viewed_service.dart';
import '../../core/services/review_service.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../../widgets/common/star_rating.dart';
import 'widgets/size_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _imageController = PageController();
  int _currentImageIndex = 0;
  int _currentNavIndex = 0;
  bool _isExpanded = false;
  final ReviewService _reviewService = ReviewService();
  double _userRating = 0;
  final _reviewController = TextEditingController();

  List<String> get _images => [
        widget.product['image'] ?? AppAssets.detail1,
        AppAssets.detail2,
        AppAssets.detail3,
        AppAssets.detail4,
        AppAssets.detail5,
      ];

  static const List<Map<String, dynamic>> _similarProducts = [
    {
      'image': AppAssets.shop7,
      'name': 'Nike Sneakers',
      'desc': 'Nike Air Jordan Retro 1 Low Mystic Black',
      'price': 1900,
      'oldPrice': 2999,
      'rating': 4.5,
      'reviews': 46890,
    },
    {
      'image': AppAssets.shop8,
      'name': 'Nike Sneakers',
      'desc': 'Mid Peach Mocha Shoes For Man White Black Pink S...',
      'price': 2500,
      'oldPrice': 3999,
      'rating': 4.5,
      'reviews': 256091,
    },
    {
      'image': AppAssets.shop9,
      'name': 'Jordan Stay',
      'desc': 'The classic Air Jordan 12 to create a shoe...',
      'price': 4999,
      'oldPrice': 7999,
      'rating': 4.0,
      'reviews': 10234,
    },
    {
      'image': AppAssets.shop10,
      'name': 'Black Jacket',
      'desc': 'This warm and comfortable jacket...',
      'price': 2999,
      'oldPrice': 4999,
      'rating': 4.0,
      'reviews': 223569,
    },
  ];

  @override
  void initState() {
    super.initState();
    AnalyticsService().trackProductView(widget.product['name'] ?? '');
    RecentlyViewedService().addProduct(widget.product);
  }

  @override
  void dispose() {
    _imageController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
  void _showCompareDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Compare Products',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Current Product
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          widget.product['image'] ?? '',
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product['name'] ?? '',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          '₹${widget.product['price']}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.compare_arrows,
                    color: AppColors.primary, size: 32),
                const SizedBox(width: 16),
                // Compare product
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.trending,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.lightBorder),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Icon(Iconsax.add_circle,
                              size: 40, color: AppColors.grey),
                          SizedBox(height: 8),
                          Text(
                            'Select Product',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Compare Table
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightBorder.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _CompareRow(
                      label: 'Price',
                      value: '₹${widget.product['price']}'),
                  _CompareRow(
                      label: 'Rating',
                      value:
                      '${widget.product['rating'] ?? 'N/A'} ⭐'),
                  _CompareRow(
                      label: 'Discount',
                      value:
                      '${widget.product['discount'] ?? 'N/A'}'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Close',
                  style: TextStyle(color: AppColors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LanguageProvider>(context);

    final String fullDesc = widget.product['desc'] ??
        'Perhaps the most iconic sneaker of all-time, this original "Chicago"? colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. This 2015 release saw the shoe return in its full glory.';

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
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.placeOrder),
                    child: const Icon(Iconsax.shopping_cart, size: 24),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Slider
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            height: 280,
                            child: PageView.builder(
                              controller: _imageController,
                              itemCount: _images.length,
                              onPageChanged: (index) {
                                setState(() => _currentImageIndex = index);
                              },
                              itemBuilder: (context, index) {
                                return Image.asset(
                                  _images[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 120,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(alpha: 0.1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          child: AnimatedSmoothIndicator(
                            activeIndex: _currentImageIndex,
                            count: _images.length,
                            effect: const ExpandingDotsEffect(
                              activeDotColor: AppColors.primary,
                              dotColor: AppColors.lightBorder,
                              dotHeight: 6,
                              dotWidth: 6,
                              expansionFactor: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Size Label
                    const Text(
                      'Size: 7UK',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Size Selector
                    const SizeSelector(),
                    const SizedBox(height: 16),

                    // Product Name
                    Text(
                      widget.product['name'] ?? 'Product',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.product['desc'] ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        StarRating(
                          rating: (widget.product['rating'] ?? 0).toDouble(),
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.product['reviews'] ?? ''}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Price
                    Row(
                      children: [
                        Text(
                          '₹${widget.product['oldPrice'] ?? ''}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₹${widget.product['price'] ?? ''}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${widget.product['discount'] ?? ''}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Product Details
                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _isExpanded
                          ? fullDesc
                          : '${fullDesc.substring(0, fullDesc.length > 120 ? 120 : fullDesc.length)}...',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.grey,
                        height: 1.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      child: Text(
                        _isExpanded ? 'Less' : '...More',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tags Row
                    const Row(
                      children: [
                        _TagChip(
                          icon: Iconsax.location,
                          label: 'Nearest Store',
                        ),
                        SizedBox(width: 8),
                        _TagChip(
                          icon: Iconsax.crown,
                          label: 'VIP',
                        ),
                        SizedBox(width: 8),
                        _TagChip(
                          icon: Iconsax.refresh,
                          label: 'Return policy',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Wishlist Button
                    Consumer<WishlistProvider>(
                      builder: (context, wishlist, _) {
                        final isWishlisted =
                            wishlist.isWishlisted(widget.product['name']);
                        return GestureDetector(
                          onTap: () => wishlist.toggleWishlist(widget.product),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isWishlisted
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isWishlisted
                                      ? lang.wishlist
                                      : lang.addToWishlist,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // Cart + Buy Now buttons
                    Row(
                      children: [
                        Expanded(
                          child: Consumer<CartProvider>(
                            builder: (context, cart, _) {
                              final isInCart =
                                  cart.isInCart(widget.product['name'] ?? '');
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (isInCart) {
                                    Navigator.pushNamed(
                                        context, AppRoutes.placeOrder);
                                  } else {
                                    cart.addToCart(widget.product);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Added to cart!'),
                                        backgroundColor: AppColors.primary,
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Iconsax.shopping_cart,
                                    color: AppColors.white, size: 18),
                                label: Text(
                                  isInCart ? lang.goToCart : lang.addToCart,
                                  style:
                                      const TextStyle(color: AppColors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.checkout),
                            icon: const Icon(Icons.bolt,
                                color: AppColors.white, size: 18),
                            label: Text(
                              lang.buyNow,
                              style: const TextStyle(color: AppColors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Delivery Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery in',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                            ),
                          ),
                          Text(
                            '1 within Hour',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // View Similar + Add to Compare
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.similarProducts,
                              arguments: widget.product,
                            ),
                            icon: const Icon(Iconsax.eye, size: 16, color: AppColors.grey),
                            label: const Text('View Similar',
                                style: TextStyle(color: AppColors.grey)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.lightBorder),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showCompareDialog(),
                            icon: const Icon(Iconsax.document_copy,
                                size: 16, color: AppColors.grey),
                            label: const Text('Add to Compare',
                                style: TextStyle(color: AppColors.grey)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.lightBorder),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _ReviewSection(
                      productName: widget.product['name'] ?? '',
                      reviewService: _reviewService,
                      userRating: _userRating,
                      reviewController: _reviewController,
                      onRatingChanged: (rating) =>
                          setState(() => _userRating = rating),
                    ),
                    const SizedBox(height: 16),
                    // Similar To Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Similar To',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '282+ Items',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
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
                    const SizedBox(height: 12),

                    // Similar Products
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _similarProducts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final product = _similarProducts[index];
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.productDetail,
                              arguments: product,
                            ),
                            child: Container(
                              width: 150,
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
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Image.asset(
                                      product['image'],
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          product['desc'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColors.grey,
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
                                        StarRating(
                                          rating: (product['rating'] as num)
                                              .toDouble(),
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

class _TagChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TagChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightBorder),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.grey),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewSection extends StatefulWidget {
  final String productName;
  final ReviewService reviewService;
  final double userRating;
  final TextEditingController reviewController;
  final Function(double) onRatingChanged;

  const _ReviewSection({
    required this.productName,
    required this.reviewService,
    required this.userRating,
    required this.reviewController,
    required this.onRatingChanged,
  });

  @override
  State<_ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<_ReviewSection> {
  bool _isSubmitting = false;
  bool _hasReviewed = false;

  @override
  void initState() {
    super.initState();
    _checkReviewed();
  }

  Future<void> _checkReviewed() async {
    final hasReviewed =
        await widget.reviewService.hasReviewed(widget.productName);
    setState(() => _hasReviewed = hasReviewed);
  }

  void _submitReview() async {
    if (widget.userRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    setState(() => _isSubmitting = true);
    await widget.reviewService.addReview(
      productName: widget.productName,
      rating: widget.userRating,
      review: widget.reviewController.text.trim(),
    );
    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _hasReviewed = true;
    });
    widget.reviewController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Review submitted! ✅'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reviews Header
        const Text(
          'Reviews',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Reviews List
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: widget.reviewService.getReviews(widget.productName),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'No reviews yet. Be the first!',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              );
            }

            return Column(
              children: snapshot.data!.map((review) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review['userEmail'] ?? 'User',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < (review['rating'] as num)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (review['review'] != null &&
                          review['review'].isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          review['review'],
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 12),

        // Add Review
        if (!_hasReviewed) ...[
          const Text(
            'Write a Review',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          // Star Rating
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => widget.onRatingChanged((index + 1).toDouble()),
                child: Icon(
                  index < widget.userRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 32,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: widget.reviewController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Write your review...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Submit Review',
                      style: TextStyle(color: AppColors.white),
                    ),
            ),
          ),
        ] else
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.success),
                SizedBox(width: 8),
                Text(
                  'You have already reviewed this product',
                  style: TextStyle(color: AppColors.success),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
class _CompareRow extends StatelessWidget {
  final String label;
  final String value;

  const _CompareRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.grey)),
          Text(value,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
