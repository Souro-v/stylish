import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Personal Details
  final _emailController =
  TextEditingController(text: 'aashifa@gmail.com');
  final _passwordController =
  TextEditingController(text: '***********');

  // Business Address
  final _pincodeController = TextEditingController(text: '450116');
  final _addressController =
  TextEditingController(text: '216 St Paul\'s Rd,');
  final _cityController = TextEditingController(text: 'London');
  final _stateController = TextEditingController(text: 'N1 2LL,');
  final _countryController =
  TextEditingController(text: 'United Kingdom');

  // Bank Details
  final _bankAccountController =
  TextEditingController(text: '204356XXXXXXX');
  final _accountHolderController =
  TextEditingController(text: 'Abhiraj Sisodiya');
  final _ifscController = TextEditingController(text: 'SBIN00428');

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pincodeController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _bankAccountController.dispose();
    _accountHolderController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _profileImage = File(image.path));
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved!')),
        );
      });
    }
  }

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
                  // Settings Icon
                  GestureDetector(
                    onTap: () {
                      // Settings options - পরে add করব
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) => const _SettingsSheet(),
                      );
                    },
                    child: const Icon(Iconsax.setting_2, size: 22),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Profile Avatar
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.lightBorder,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : null,
                              child: _profileImage == null
                                  ? const Icon(
                                Iconsax.user,
                                size: 50,
                                color: AppColors.grey,
                              )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 14,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Personal Details
                      const Text(
                        'Personal Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text('Email Address',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Email Address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      const Text('Password',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Business Address Details
                      const Text(
                        'Business Address Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text('Pincode',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Pincode',
                        controller: _pincodeController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      const Text('Address',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Address',
                        controller: _addressController,
                      ),
                      const SizedBox(height: 16),

                      const Text('City',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'City',
                        controller: _cityController,
                      ),
                      const SizedBox(height: 16),

                      const Text('State',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'State',
                        controller: _stateController,
                        suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.grey),
                      ),
                      const SizedBox(height: 16),

                      const Text('Country',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Country',
                        controller: _countryController,
                      ),
                      const SizedBox(height: 24),

                      // Bank Account Details
                      const Text(
                        'Bank Account Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text('Bank Account Number',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Bank Account Number',
                        controller: _bankAccountController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      const Text('Account Holder\'s Name',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Account Holder\'s Name',
                        controller: _accountHolderController,
                      ),
                      const SizedBox(height: 16),

                      const Text('IFSC Code',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'IFSC Code',
                        controller: _ifscController,
                      ),
                      const SizedBox(height: 24),

                      // Save Button
                      CustomButton(
                        text: 'Save',
                        onPressed: _onSave,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSheet extends StatelessWidget {
  const _SettingsSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.lightBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Dark Mode Toggle
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  themeProvider.isDarkMode
                      ? Iconsax.moon
                      : Iconsax.sun_1,
                  color: AppColors.primary,
                ),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  activeThumbColor: AppColors.primary,
                  onChanged: (_) => themeProvider.toggleTheme(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}