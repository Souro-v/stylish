import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/custom_button.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String _selectedSize = '42';
  int _selectedQty = 1;

  final List<String> _sizes = ['38', '40', '42', '44', '46'];
  final List<int> _quantities = [1, 2, 3, 4, 5];

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
                    'Shopping Bag',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Iconsax.heart, size: 22),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Product Card
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              AppAssets.deal1,
                              width: 100,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Product Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Women's Casual Wear",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Checked Single-Breasted Blazer',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Size + Qty
                                Row(
                                  children: [
                                    // Size Dropdown
                                    const Text(
                                      'Size ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.lightBorder),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _selectedSize,
                                          isDense: true,
                                          items: _sizes
                                              .map((s) => DropdownMenuItem(
                                                    value: s,
                                                    child: Text(s,
                                                        style: const TextStyle(
                                                            fontSize: 12)),
                                                  ))
                                              .toList(),
                                          onChanged: (val) => setState(
                                              () => _selectedSize = val!),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Qty Dropdown
                                    const Text(
                                      'Qty ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.lightBorder),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: _selectedQty,
                                          isDense: true,
                                          items: _quantities
                                              .map((q) => DropdownMenuItem(
                                                    value: q,
                                                    child: Text('$q',
                                                        style: const TextStyle(
                                                            fontSize: 12)),
                                                  ))
                                              .toList(),
                                          onChanged: (val) => setState(
                                              () => _selectedQty = val!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Delivery
                                const Row(
                                  children: [
                                    Text(
                                      'Delivery by ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    Text(
                                      '10 May 2XXX',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
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
                    const SizedBox(height: 16),

                    // Apply Coupons
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Iconsax.discount_shape,
                                  size: 20, color: AppColors.grey),
                              SizedBox(width: 10),
                              Text(
                                'Apply Coupons',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Select',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Order Payment Details
                    Container(
                      padding: const EdgeInsets.all(16),
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
                          const Text(
                            'Order Payment Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Order Amounts
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Amounts',
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.grey)),
                              Text('₹ 7,000.00',
                                  style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Convenience
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text('Convenience ',
                                      style: TextStyle(
                                          fontSize: 13, color: AppColors.grey)),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Know More',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Apply Coupon',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Delivery Fee
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Fee',
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.grey)),
                              Text(
                                'Free',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),

                          // Order Total
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Total',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '₹ 7,000.00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // EMI
                          Row(
                            children: [
                              const Text(
                                'EMI Available ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Details',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '₹7,000.00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                text: 'Proceed to Payment',
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.checkout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
