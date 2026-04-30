import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  static const List<Map<String, String>> _categories = [
    {'name': 'Beauty', 'image': AppAssets.catBeauty},
    {'name': 'Fashion', 'image': AppAssets.catFashion},
    {'name': 'Kids', 'image': AppAssets.catKids},
    {'name': 'Mens', 'image': AppAssets.catMens},
    {'name': 'Womens', 'image': AppAssets.catWomens},
    {'name': 'Gifts', 'image': AppAssets.catGifts},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    _categories[index]['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _categories[index]['name']!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grey,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}