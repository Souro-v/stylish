import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isScanned = false;
  bool _torchOn = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScanned) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    setState(() => _isScanned = true);
    _controller.stop();

    final value = barcode!.rawValue!;
    _showResultDialog(value);
  }

  void _showResultDialog(String value) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Scan Result'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.scan,
              color: AppColors.primary,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isScanned = false);
              _controller.start();
            },
            child: const Text(
              'Scan Again',
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Search product by barcode
              Navigator.pushNamed(
                context,
                AppRoutes.search,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text(
              'Search Product',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scanner
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),

          // Overlay
          SafeArea(
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
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const Text(
                        'Scan Product',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.toggleTorch();
                          setState(() => _torchOn = !_torchOn);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _torchOn
                                ? Iconsax.flash
                                : Iconsax.flash_slash,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Scan Frame
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        // Corner decorations
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: AppColors.primary, width: 4),
                                left: BorderSide(
                                    color: AppColors.primary, width: 4),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: AppColors.primary, width: 4),
                                right: BorderSide(
                                    color: AppColors.primary, width: 4),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.primary, width: 4),
                                left: BorderSide(
                                    color: AppColors.primary, width: 4),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.primary, width: 4),
                                right: BorderSide(
                                    color: AppColors.primary, width: 4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Point camera at barcode or QR code',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),

                const Spacer(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}