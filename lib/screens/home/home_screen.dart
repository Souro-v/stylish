import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/providers/wishlist_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../vendor/vendor_service.dart';
import 'widgets/banner_slider.dart';
import 'widgets/category_row.dart';
import 'widgets/deal_of_day_card.dart';
import 'widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).updateLastActive();
      Provider.of<CartProvider>(context, listen: false).loadCart();
      Provider.of<WishlistProvider>(context, listen: false).loadWishlist();
    });
  }

  Widget _buildDrawer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Iconsax.user,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Stylish User',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Menu Items
            _DrawerItem(
              icon: Iconsax.home,
              title: 'Home',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _DrawerItem(
              icon: Iconsax.category,
              title: 'Beauty',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.beauty);
              },
            ),
            _DrawerItem(
              icon: Iconsax.category,
              title: 'Fashion',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.fashion);
              },
            ),
            _DrawerItem(
              icon: Iconsax.category,
              title: 'Kids',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.kids);
              },
            ),
            _DrawerItem(
              icon: Iconsax.category,
              title: 'Mens',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.mens);
              },
            ),
            _DrawerItem(
              icon: Iconsax.category,
              title: 'Womens',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.womens);
              },
            ),
            _DrawerItem(
              icon: Iconsax.category,
              title: 'Gifts',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.gifts);
              },
            ),
            _DrawerItem(
              icon: Iconsax.heart,
              title: 'Wishlist',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.wishlist);
              },
            ),
            _DrawerItem(
              icon: Iconsax.shopping_bag,
              title: 'My Orders',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.orders);
              },
            ),
            _DrawerItem(
              icon: Iconsax.shop,
              title: 'Vendor Dashboard',
              onTap: () async {
                Navigator.pop(context);
                final isVendor = await VendorService().isVendor();
                if (!context.mounted) return;
                if (isVendor) {
                  Navigator.pushNamed(context, AppRoutes.vendorDashboard);
                } else {
                  Navigator.pushNamed(context, AppRoutes.vendorRegister);
                }
              },
            ),

            const Spacer(),

            // Settings + Logout
            _DrawerItem(
              icon: Iconsax.setting_2,
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.profile);
              },
            ),
            _DrawerItem(
              icon: Iconsax.chart,
              title: 'Analytics',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.analytics);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _trendingProducts = [
    {
      'image': AppAssets.trending1,
      'name': 'IWC Schaffhausen 2021 Pilot\'s Watch "SIHH 2019" 44mm',
      'price': 650,
      'oldPrice': 1599,
      'discount': '60% off',
      'rating': 4.0,
    },
    {
      'image': AppAssets.trending2,
      'name': 'Labbin White Sneakers For Men and Female',
      'price': 650,
      'oldPrice': 1250,
      'discount': '70% off',
      'rating': 4.5,
    },
    {
      'image': AppAssets.trending3,
      'name': 'Mammon Women\'s Handbag (Set of 3, Beige)',
      'price': 750,
      'oldPrice': 1999,
      'discount': '60% off',
      'rating': 4.0,
    },
    {
      'image': AppAssets.trending4,
      'name': 'Do Bhai Women Wedges Sandal (Butterfly)',
      'price': 750,
      'oldPrice': 1499,
      'discount': '50% off',
      'rating': 4.5,
    },
    {
      'image': AppAssets.trending5,
      'name': 'Lakme Enrich Matte Lipstick - Shade RM1(4.7gm)',
      'price': 950,
      'oldPrice': 1990,
      'discount': '60% off',
      'rating': 4.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: const Icon(Iconsax.menu, size: 24),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(AppAssets.logo, width: 32, height: 32),
                      const SizedBox(width: 6),
                      Text(
                        lang.appName,
                        style: const TextStyle(
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

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.search),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkCard
                              : AppColors.lightScaffoldBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Iconsax.search_normal,
                                color: AppColors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: lang.searchProduct,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            const Icon(Iconsax.microphone,
                                color: AppColors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // All Featured Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang.allFeatured,
                          style: const TextStyle(
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
                    const SizedBox(height: 12),

                    // Categories
                    const CategoryRow(),
                    const SizedBox(height: 16),

                    // Banner Slider
                    const BannerSlider(),
                    const SizedBox(height: 16),

                    // Flash Sale Banner
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.flashSale),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Iconsax.flash,
                                    color: AppColors.white, size: 24),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang.flashSale,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const Text(
                                      'Up to 67% Off',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                color: AppColors.white, size: 16),
                          ],
                        ),
                      ),
                    ),

                    // Deal of the Day
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.dealOfDay,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Row(
                                children: [
                                  Icon(Iconsax.clock,
                                      size: 14, color: AppColors.white),
                                  SizedBox(width: 4),
                                  Text(
                                    '22h 55m 20s remaining',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.dealOfDay),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    lang.viewAll,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.arrow_forward,
                                      size: 12, color: AppColors.primary),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Deal Cards
                    const DealOfDayCard(),
                    const SizedBox(height: 16),

                    // Special Offers
                    Container(
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
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.specialOffers),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAssets.specialOffersIcon,
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Special Offers 😱',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'We make sure you get the\noffer you need at best prices',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Flat and Heels Banner
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.flatHeels),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          AppAssets.flatHeelsBanner,
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Trending Products Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.trendingProducts,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Row(
                                children: [
                                  Icon(Iconsax.calendar,
                                      size: 14, color: AppColors.white),
                                  SizedBox(width: 4),
                                  Text(
                                    'Last Date 29/02/22',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.wishlist),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    lang.viewAll,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.arrow_forward,
                                      size: 12, color: AppColors.primary),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Trending Products List
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _trendingProducts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final product = _trendingProducts[index];
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.productDetail,
                                arguments: product),
                            child: Container(
                              width: 140,
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
                                          height: 120,
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
                                                          .withValues(
                                                              alpha: 0.1),
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
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
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
                                        Row(
                                          children: [
                                            Text(
                                              '₹${product['oldPrice']}',
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: AppColors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              product['discount'],
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: AppColors.primary,
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
                    const SizedBox(height: 16),

                    // Hot Summer Sale Banner
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.summerSale),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          AppAssets.hotSummerSale,
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // New Arrivals
                    SectionHeader(
                      title: lang.newArrivals,
                      subtitle: "Summer' 25 Collections",
                      onViewAll: () =>
                          Navigator.pushNamed(context, AppRoutes.newArrivals),
                    ),
                    const SizedBox(height: 16),

                    // Sponsored Banner
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.sponsoredScreen),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
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
                                AppAssets.sponsoredBanner,
                                width: double.infinity,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkCard
                                    : AppColors.white,
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(12),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'up to 50% Off',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: AppColors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 8,
    );
  }
}
