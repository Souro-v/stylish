import 'package:flutter/material.dart';
import 'package:stylish/core/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  static const List<Map<String, String>> _categories = [
    {
      'name': 'Beauty',
      'image': AppAssets.catBeauty,
      'route': AppRoutes.beauty,
    },
    {
      'name': 'Fashion',
      'image': AppAssets.catFashion,
      'route': AppRoutes.fashion,
    },
    {
      'name': 'Kids',
      'image': AppAssets.catKids,
      'route': AppRoutes.kids,
    },
    {
      'name': 'Mens',
      'image': AppAssets.catMens,
      'route': AppRoutes.mens,
    },
    {
      'name': 'Womens',
      'image': AppAssets.catWomens,
      'route': AppRoutes.womens,
    },
    {
      'name': 'Gifts',
      'image': AppAssets.catGifts,
      'route': AppRoutes.gifts,
    },
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
          return InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {
              Navigator.pushNamed(
                context,
                _categories[index]['route']!,
              );
            },
            child: Column(
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
            ),
          );
        },
      ),
    );
  }
}
