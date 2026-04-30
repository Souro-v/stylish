import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';

class DealOfDayCard extends StatefulWidget {
  const DealOfDayCard({super.key});

  @override
  State<DealOfDayCard> createState() => _DealOfDayCardState();
}

class _DealOfDayCardState extends State<DealOfDayCard> {
  static const List<Map<String, dynamic>> _deals = [
    {
      'image': AppAssets.deal1,
      'name': 'Women Printed Kurta',
      'desc': 'Neque porro quisquam est qui dolorem ipsum quia',
      'price': 1500,
      'oldPrice': 2500,
      'discount': '40%Off',
      'rating': 4.5,
      'reviews': 56890,
    },
    {
      'image': AppAssets.deal2,
      'name': 'HRX by Hrithik Roshan',
      'desc': 'Neque porro quisquam est qui dolorem ipsum quia',
      'price': 2499,
      'oldPrice': 4999,
      'discount': '50%Off',
      'rating': 4.5,
      'reviews': 344567,
    },
    {
      'image': AppAssets.deal3,
      'name': 'Philips BHH880/10',
      'desc': 'Hair Straightening Brush With Keratin Infused Bristles (Black).',
      'price': 999,
      'oldPrice': 1999,
      'discount': '50%Off',
      'rating': 4.5,
      'reviews': 646776,
    },
    {
      'image': AppAssets.deal4,
      'name': 'TITAN Men Watch- 1806N',
      'desc': 'This Titan watch in Black color is I wanted to buy for a long time',
      'price': 1500,
      'oldPrice': 3500,
      'discount': '60%Off',
      'rating': 4.0,
      'reviews': 15007,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _deals.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final deal = _deals[index];
          return Container(
            width: 160,
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
                    deal['image'],
                    height: 140,
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
                        deal['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        deal['desc'],
                        maxLines: 2,
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
                            '₹${deal['price']}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '₹${deal['oldPrice']}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        deal['discount'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}