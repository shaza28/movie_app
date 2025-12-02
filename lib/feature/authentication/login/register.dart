import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/resourses/app_colors.dart';
import '../../../core/resourses/widget/custom_elevated_buttom.dart';
import '../../../core/resourses/widget/custom_text_button.dart';
import '../../../core/resourses/widget/custom_text_form_field.dart';
import '../../../core/resourses/widget/avatar_widget.dart';
import '../../../core/routers.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const routeName = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool securePassword = true;
  bool secureConfirmPassword = true;
  String? _selectedImagePath; // لتخزين صورة المستخدم

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _phoneController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 47.h,
            left: 24.w,
            right: 24.w,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: AppColors.yellow),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.yellow,
                  ),
                ),
                SizedBox(height: 40.h),

                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    AvatarWidget(
                      size: 100,
                      imageUrl: _selectedImagePath,
                      userName: _nameController.text.isNotEmpty
                          ? _nameController.text
                          : null,
                      backgroundColor: Colors.grey[800]!,
                      textColor: Colors.white,
                      hasNotification: false,
                      onTap: _pickImage,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: AppColors.yellow,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      validator: _validateName,
                      hintText: "Name",
                      keyboardType: TextInputType.name,
                      prefixIcon: Icon(Icons.person, color: AppColors.white),
                      onChanged: (value) => setState(() {}),
                    ),
                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      controller: _emailController,
                      validator: _validateEmail,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.email, color: AppColors.white),
                    ),
                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      controller: _passwordController,
                      validator: _validatePassword,
                      isSecure: securePassword,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icon(Icons.lock, color: AppColors.white),
                      suffixIcon: IconButton(
                        onPressed: _onTogglePasswordIconClicked,
                        icon: Icon(
                          securePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      validator: _validateConfirmPassword,
                      isSecure: secureConfirmPassword,
                      hintText: "Confirm Password",
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icon(Icons.lock, color: AppColors.white),
                      suffixIcon: IconButton(
                        onPressed: _onToggleConfirmPasswordIconClicked,
                        icon: Icon(
                          secureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      controller: _phoneController,
                      validator: _validatePhone,
                      hintText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icon(Icons.phone, color: AppColors.white),
                    ),
                    SizedBox(height: 40.h),

                    CustomElevatedButton(
                      text: "Create Account",
                      onPress: _register,
                    ),
                    SizedBox(height: 24.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account?",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        CustomTextButton(
                          text: "Login",
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.login);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دوال مساعدة
  void _onTogglePasswordIconClicked() {
    setState(() => securePassword = !securePassword);
  }

  void _onToggleConfirmPasswordIconClicked() {
    setState(() => secureConfirmPassword = !secureConfirmPassword);
  }

  void _register() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  String? _validateName(String? value) =>
      (value == null || value.isEmpty) ? 'Please enter your name' : null;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!value.contains('@')) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    if (value.length < 10) return 'Please enter a valid phone number';
    return null;
  }
}





/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resourses/app_colors.dart';
import '../../../core/resourses/app_images.dart';
import '../../../core/resourses/widget/custom_elevated_buttom.dart';
import '../../../core/resourses/widget/custom_text_button.dart';
import '../../../core/resourses/widget/custom_text_form_field.dart';
import '../../../core/routers.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const routeName = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool securePassword = true;
  bool secureConfirmPassword = true;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _phoneController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 47.h,
            left: 24.w,
            right: 24.w,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color:AppColors.yellow),
                  ),
                ),
                SizedBox(height: 20.h),
               Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color:AppColors.yellow,
                  ),
                ),
                SizedBox(height: 40.h),

                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.grey[800],
                      child: Icon(
                        Icons.person,
                        size: 50.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.edit,
                          size: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      validator: _validateName,
                      hintText: "Name",
                      keyboardType: TextInputType.name,
                      prefixIcon: Icon(Icons.person, color:AppColors.white),
                    ),
                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      controller: _emailController,
                      validator: _validateEmail,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.email, color:AppColors.white),
                    ),
                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      controller: _passwordController,
                      validator: _validatePassword,
                      isSecure: securePassword,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icon(Icons.lock, color:AppColors.white),
                      suffixIcon: IconButton(
                        onPressed: _onTogglePasswordIconClicked,
                        icon: Icon(
                          securePassword ? Icons.visibility_off : Icons.visibility,
                          color:AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),


                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      validator: _validateConfirmPassword,
                      isSecure: secureConfirmPassword,
                      hintText: "Confirm Password",
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icon(Icons.lock, color: AppColors.white),
                      suffixIcon: IconButton(
                        onPressed: _onToggleConfirmPasswordIconClicked,
                        icon: Icon(
                          secureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),


                    CustomTextFormField(
                      controller: _phoneController,
                      validator: _validatePhone,
                       hintText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icon(Icons.phone, color: AppColors.white),
                    ),
                    SizedBox(height: 40.h),


                    CustomElevatedButton(
                      text: "Create Account",
                      onPress: _register,
                    ),
                    SizedBox(height: 24.h),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account?",
                          style: TextStyle(
                            color:AppColors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        CustomTextButton(
                          text: "Login",
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.login
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTogglePasswordIconClicked() {
    setState(() {
      securePassword = !securePassword;
    });
  }

  void _onToggleConfirmPasswordIconClicked() {
    setState(() {
      secureConfirmPassword = !secureConfirmPassword;
    });
  }

  void _register() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  void _createAccount() async {
    
    if (_formKey.currentState?.validate() == false) return;

}
}
*/
