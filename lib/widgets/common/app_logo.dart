import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';

class AppLogo extends StatelessWidget {
  final double imageSize;
  final double fontSize;

  const AppLogo({
    super.key,
    this.imageSize = 60,
    this.fontSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppAssets.logo,
          width: imageSize,
          height: imageSize,
        ),
        const SizedBox(width: 8),
        Text(
          'Stylish',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}