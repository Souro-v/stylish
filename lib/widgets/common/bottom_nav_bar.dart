import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/language_provider.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LanguageProvider>(context);

    return Container(
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
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.home),
            activeIcon: const Icon(Iconsax.home_15),
            label: lang.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.heart),
            activeIcon: const Icon(Iconsax.heart5),
            label: lang.wishlist,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.shopping_cart),
            activeIcon: const Icon(Iconsax.shopping_cart1),
            label: lang.cart,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.search_normal),
            activeIcon: const Icon(Iconsax.search_normal_1),
            label: lang.search,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.user),
            activeIcon: const Icon(Iconsax.user),
            label: lang.profile,
          ),
        ],
      ),
    );
  }
}
