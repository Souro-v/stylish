import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings - Light
  static const TextStyle h1Light = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.lightTextDark,
  );

  static const TextStyle h2Light = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.lightTextDark,
  );

  static const TextStyle h3Light = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.lightTextDark,
  );

  // Headings - Dark
  static const TextStyle h1Dark = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.darkTextDark,
  );

  static const TextStyle h2Dark = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.darkTextDark,
  );

  static const TextStyle h3Dark = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkTextDark,
  );

  // Body - Light
  static const TextStyle bodyLargeLight = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.lightTextDark,
  );

  static const TextStyle bodyMediumLight = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.lightTextDark,
  );

  static const TextStyle bodySmallLight = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.lightTextGrey,
  );

  // Body - Dark
  static const TextStyle bodyLargeDark = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextDark,
  );

  static const TextStyle bodyMediumDark = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextDark,
  );

  static const TextStyle bodySmallDark = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextGrey,
  );

  // Button Text
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // Price
  static const TextStyle priceStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle oldPriceStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.grey,
    decoration: TextDecoration.lineThrough,
  );

  // Caption
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: AppColors.grey,
  );
}