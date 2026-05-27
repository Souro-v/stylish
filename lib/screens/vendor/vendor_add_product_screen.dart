import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylish/screens/vendor/vendor_service.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class VendorAddProductScreen extends StatefulWidget {
  const VendorAddProductScreen({super.key});

  @override
  State<VendorAddProductScreen> createState() => _VendorAddProductScreenState();
}

class _VendorAddProductScreenState extends State<VendorAddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _oldPriceController = TextEditingController();
  final _discountController = TextEditingController();
  bool _isLoading = false;
  final VendorService _vendorService = VendorService();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _oldPriceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _onAddProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      await _vendorService.addProduct({
        'name': _nameController.text.trim(),
        'desc': _descController.text.trim(),
        'price': int.parse(_priceController.text.trim()),
        'oldPrice': int.parse(_oldPriceController.text.trim()),
        'discount': _discountController.text.trim(),
        'rating': 0.0,
        'reviews': 0,
        'image': 'assets/products/shop_1.png',
      });

      if (!mounted) return;
      setState(() => _isLoading = false);

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Product added successfully!'),
          backgroundColor: AppColors.success,
        ),
      );

      navigator.pushReplacementNamed(AppRoutes.vendorDashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios, size: 20),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Add Product',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                // Product Name
                const Text('Product Name',
                    style: TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: 'Enter product name',
                  controller: _nameController,
                  prefixIcon: const Icon(Iconsax.box, color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Description
                const Text('Description',
                    style: TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: 'Enter product description',
                  controller: _descController,
                  prefixIcon:
                      const Icon(Iconsax.document_text, color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Price
                const Text('Price (₹)',
                    style: TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: 'Enter price',
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Iconsax.money, color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Old Price
                const Text('Old Price (₹)',
                    style: TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: 'Enter old price',
                  controller: _oldPriceController,
                  keyboardType: TextInputType.number,
                  prefixIcon:
                      const Icon(Iconsax.money_remove, color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter old price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Discount
                const Text('Discount',
                    style: TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: 'e.g. 50%Off',
                  controller: _discountController,
                  prefixIcon:
                      const Icon(Iconsax.discount_shape, color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter discount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                CustomButton(
                  text: 'Add Product',
                  onPressed: _onAddProduct,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
