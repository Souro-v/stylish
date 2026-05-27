import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylish/screens/vendor/vendor_service.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() =>
      _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;
  final VendorService _vendorService = VendorService();

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      await _vendorService.registerVendor({
        'name': _nameController.text.trim(),
        'businessName': _businessNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'address': _addressController.text.trim(),
      });

      if (!mounted) return;
      setState(() => _isLoading = false);

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Registration successful! Awaiting approval.'),
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
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 32),
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
                  'Become a\nVendor',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Register your business and start selling',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                // Full Name
                const Text('Full Name',
                    style:
                    TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: 'Enter your full name',
                  controller: _nameController,
                  prefixIcon:
                  const Icon(Iconsax.user, color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Business Name
                const Text('Business Name',
                    style:
                    TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: 'Enter your business name',
                  controller: _businessNameController,
                  prefixIcon: const Icon(Iconsax.building,
                      color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter business name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone
                const Text('Phone Number',
                    style:
                    TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: '+880XXXXXXXXXX',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon:
                  const Icon(Icons.phone, color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Address
                const Text('Business Address',
                    style:
                    TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 6),
                CustomTextField(
                  hintText: 'Enter your business address',
                  controller: _addressController,
                  prefixIcon: const Icon(Iconsax.location,
                      color: AppColors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                CustomButton(
                  text: 'Register as Vendor',
                  onPressed: _onRegister,
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