import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/custom_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

            // Order Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text('Order',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.grey)),
                        Text('₹ 7,000',
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                     SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text('Shipping',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.grey)),
                        Text('₹  30',
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                     Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text('Total',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                        Text('₹ 7,030',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Success Animation
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Payment done successfully.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your order has been placed successfully!',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.grey,
              ),
            ),

            const Spacer(),

            // Continue Button
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 24),
              child: CustomButton(
                text: 'Continue Shopping',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                      (route) => false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}