import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/theme_provider.dart';
import '../../widgets/common/bottom_nav_bar.dart';
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
  final _emailController = TextEditingController(text: 'aashifa@gmail.com');
  final _passwordController = TextEditingController(text: '***********');

  // Business Address
  final _pincodeController = TextEditingController(text: '450116');
  final _addressController = TextEditingController(text: '216 St Paul\'s Rd,');
  final _cityController = TextEditingController(text: 'London');
  final _stateController = TextEditingController(text: 'N1 2LL,');
  final _countryController = TextEditingController(text: 'United Kingdom');

  // Bank Details
  final _bankAccountController = TextEditingController(text: '204356XXXXXXX');
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
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    if (image != null) {
      // Save image to app directory
      final directory = await getApplicationDocumentsDirectory();
      const String fileName = 'profile_image.jpg';
      final String filePath = '${directory.path}/$fileName';

      // Copy image to app directory
      await File(image.path).copy(filePath);

      setState(() => _profileImage = File(filePath));

      // Save path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', filePath);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? imagePath = prefs.getString('profile_image_path');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() => _profileImage = File(imagePath));
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
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  const Text(
                    'Profile',
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
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Email Address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      const Text('Password',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
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
                          onTap: () => _showChangePasswordDialog(),
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
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Pincode',
                        controller: _pincodeController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      const Text('Address',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Address',
                        controller: _addressController,
                      ),
                      const SizedBox(height: 16),

                      const Text('City',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'City',
                        controller: _cityController,
                      ),
                      const SizedBox(height: 16),

                      const Text('State',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'State',
                        controller: _stateController,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down,
                            color: AppColors.grey),
                      ),
                      const SizedBox(height: 16),

                      const Text('Country',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
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
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Bank Account Number',
                        controller: _bankAccountController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      const Text('Account Holder\'s Name',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'Account Holder\'s Name',
                        controller: _accountHolderController,
                      ),
                      const SizedBox(height: 16),

                      const Text('IFSC Code',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: 'IFSC Code',
                        controller: _ifscController,
                      ),
                      const SizedBox(height: 24),

                      // Save Button
                      CustomButton(
                        text: lang.save,
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
          if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.wishlist);
          }
          if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.placeOrder);
          }
          if (index == 3) {
            Navigator.pushNamed(context, AppRoutes.search);
          }
        },
      ),
    );
  }

  void _showChangePasswordDialog() {
    final currentPassController = TextEditingController();
    final newPassController = TextEditingController();
    final confirmPassController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPassController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Current Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPassController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'New Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPassController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm New Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: AppColors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (newPassController.text != confirmPassController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match'),
                    backgroundColor: AppColors.error,
                  ),
                );
                return;
              }
              try {
                final user = FirebaseAuth.instance.currentUser;
                await user?.updatePassword(newPassController.text);
                if (!context.mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to change password'),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child:
                const Text('Change', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}

class _SettingsSheet extends StatelessWidget {
  const _SettingsSheet();

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
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
          Text(
            lang.settings,
            style: const TextStyle(
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
                  themeProvider.isDarkMode ? Iconsax.moon : Iconsax.sun_1,
                  color: AppColors.primary,
                ),
                title: Text(lang.darkMode),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  activeThumbColor: AppColors.primary,
                  onChanged: (_) => themeProvider.toggleTheme(),
                ),
              );
            },
          ),
          // Language Toggle
          Consumer<LanguageProvider>(
            builder: (context, langProvider, _) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Iconsax.language_square,
                  color: AppColors.primary,
                ),
                title: Text(lang.language),
                subtitle: Text(
                  langProvider.isBangla ? 'বাংলা' : 'English',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ),
                trailing: Switch(
                  value: langProvider.isBangla,
                  activeThumbColor: AppColors.primary,
                  onChanged: (_) => langProvider.toggleLanguage(),
                ),
              );
            },
          ),
          //live chat
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Iconsax.message,
              color: AppColors.primary,
            ),
            title: const Text('Live Chat'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.chat);
            },
          ),
          // Sign Out
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Iconsax.logout,
              color: AppColors.error,
            ),
            title: Text(
              lang.logout,
              style: const TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () async {
              Navigator.pop(context); // Bottom sheet close
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              await authProvider.signOut();
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.signIn,
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
