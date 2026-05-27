import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylish/screens/vendor/vendor_service.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';

class VendorDashboardScreen extends StatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  State<VendorDashboardScreen> createState() =>
      _VendorDashboardScreenState();
}

class _VendorDashboardScreenState
    extends State<VendorDashboardScreen> {
  final VendorService _vendorService = VendorService();
  Map<String, dynamic>? _vendorData;

  @override
  void initState() {
    super.initState();
    _loadVendorData();
  }

  Future<void> _loadVendorData() async {
    final data = await _vendorService.getVendorData();
    setState(() => _vendorData = data);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vendor Dashboard',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        _vendorData?['businessName'] ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.home),
                    child: const Icon(Iconsax.home,
                        color: AppColors.white, size: 24),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Status Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _vendorData?['isApproved'] == true
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _vendorData?['isApproved'] == true
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _vendorData?['isApproved'] == true
                                ? Iconsax.tick_circle
                                : Iconsax.clock,
                            color: _vendorData?['isApproved'] == true
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _vendorData?['isApproved'] == true
                                ? 'Account Approved ✅'
                                : 'Pending Approval ⏳',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _vendorData?['isApproved'] == true
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Dashboard Menu
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        _DashboardCard(
                          icon: Iconsax.add_square,
                          title: 'Add Product',
                          color: AppColors.primary,
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.vendorAddProduct),
                        ),
                        _DashboardCard(
                          icon: Iconsax.box,
                          title: 'My Products',
                          color: Colors.blue,
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.vendorProducts),
                        ),
                        _DashboardCard(
                          icon: Iconsax.shopping_bag,
                          title: 'Orders',
                          color: Colors.green,
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.orders),
                        ),
                        _DashboardCard(
                          icon: Iconsax.chart,
                          title: 'Analytics',
                          color: Colors.orange,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Recent Products
                   const Align (
                      alignment: Alignment.centerLeft,
                      child:  Text(
                        'Recent Products',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _vendorService.getVendorProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                Icon(
                                  Iconsax.box,
                                  size: 60,
                                  color:
                                  AppColors.grey.withValues(alpha: 0.4),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'No products yet!',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final products = snapshot.data!;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkCard
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black
                                        .withValues(alpha: 0.05),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '₹${product['price']}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        _vendorService.deleteProduct(
                                            product['id']),
                                    child: const Icon(
                                      Iconsax.trash,
                                      color: AppColors.error,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}