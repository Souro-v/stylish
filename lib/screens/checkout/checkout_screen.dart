import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../../widgets/common/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPayment = 0;
  int _currentNavIndex = 2;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'icon': AppAssets.visaIcon,
      'number': '********2109',
    },
    {
      'icon': AppAssets.bkashIcon,
      'number': '********2109',
    },
    {
      'icon': AppAssets.nagadIcon,
      'number': '********2109',
    },
    {
      'icon': AppAssets.rocketIcon,
      'number': '********2109',
    },
  ];

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
                    'Checkout',
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Order Summary
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkCard
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          // Order
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children:  [
                              Text(
                                'Order',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.grey,
                                ),
                              ),
                              Text(
                                '₹ 7,000',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                           SizedBox(height: 10),

                          // Shipping
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children:  [
                              Text(
                                'Shipping',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.grey,
                                ),
                              ),
                              Text(
                                '₹  30',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                           Divider(height: 24),

                          // Total
                        Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children:  [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '₹ 7,030',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payment Title
                    const Text(
                      'Payment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Payment Options
                    ...List.generate(_paymentMethods.length, (index) {
                      final method = _paymentMethods[index];
                      final isSelected = _selectedPayment == index;

                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedPayment = index),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkCard
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.lightBorder,
                              width: isSelected ? 1.5 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.04),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                method['icon'],
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                              Text(
                                method['number'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.grey,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),

                    // Continue Button
                    CustomButton(
                      text: 'Continue',
                      onPressed: () => Navigator.pushNamed(
                          context, AppRoutes.success),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) =>
            setState(() => _currentNavIndex = index),
      ),
    );
  }
}