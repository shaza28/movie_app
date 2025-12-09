import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/UI_Utils.dart';
// إزالة: import 'package:movie_app/feature/models/user_model.dart';
// إزالة: import 'package:movie_app/firebase/firebase_service.dart';
// إزالة: import 'package:firebase_auth/firebase_auth.dart';
// إزالة: import 'package:firebase_core/firebase_core.dart';

import '../../../core/resourses/app_colors.dart';
import '../../../core/resourses/widget/custom_elevated_buttom.dart';
import '../../../core/resourses/widget/custom_text_button.dart';
import '../../../core/resourses/widget/custom_text_form_field.dart';
// استيراد خدمة الـ REST API الجديدة
import '../../../core/routers.dart';
import '../../../core/services/rest_api_services.dart';
import '../../models/register_request.dart';



class Register extends StatefulWidget {
  const Register({super.key});
  static const routeName = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static const List<String> _defaultAvatars = [
    'assets/avatars/gamer(1).png',
    'assets/avatars/gamer(2).png',
    'assets/avatars/gamer(3).png',
  ];

  bool securePassword = true;
  bool secureConfirmPassword = true;

  String? _selectedImagePath = _defaultAvatars.first;

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


                SizedBox(
                  height: 120.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _defaultAvatars.sublist(0, 3).map((avatarPath) {
                      final isSelected = _selectedImagePath == avatarPath;
                      // تحديد حجم الأفاتار: 50.r للمختار، 40.r للآخرين
                      final radius = isSelected ? 50.r : 40.r;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImagePath = avatarPath;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            border: isSelected
                                ? Border.all(color: AppColors.yellow, width: 4.w)
                                : null,
                          ),
                          child: CircleAvatar(
                            radius: radius,
                            backgroundImage: AssetImage(avatarPath),
                            backgroundColor: Colors.grey[800],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // -----------------------------------------------------------------

                SizedBox(height: 30.h), // مسافة قبل حقول الإدخال

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

  void _onTogglePasswordIconClicked() {
    setState(() => securePassword = !securePassword);
  }

  void _onToggleConfirmPasswordIconClicked() {
    setState(() => secureConfirmPassword = !secureConfirmPassword);
  }

  void _register() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        UIUtils.showLoading(context,isDismissible: false);

        // 1. تجميع بيانات الطلب
        RegisterRequest requestData = RegisterRequest(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phoneNumber: _phoneController.text,
          imageUrl: _selectedImagePath,
        );

        // 2. استدعاء دالة الـ API الجديدة
        await RestApiServices.register(requestData);

        // في حالة النجاح:
        UIUtils.hideDialog(context);
        UIUtils.showToastMessage("Successfully Registration",Colors.green );
        Navigator.pushReplacementNamed(context,AppRoutes.login);

      }
      // تم تعديل معالجة الأخطاء لاستقبال الاستثناء المرمي من خدمة الـ API
      on Exception catch (exception) {
        UIUtils.hideDialog(context);
        // إزالة الجزء 'Exception: ' لعرض الرسالة النظيفة
        UIUtils.showToastMessage(exception.toString().replaceFirst('Exception: ', ''), Colors.red);
      }
      catch(exception){
        UIUtils.hideDialog(context);
        UIUtils.showToastMessage("Failed to register: Unknown error",Colors.red );

      }

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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/UI_Utils.dart';
import 'package:movie_app/feature/models/user_model.dart';
import 'package:movie_app/firebase/firebase_service.dart';
import '../../../core/resourses/app_colors.dart';
import '../../../core/resourses/widget/custom_elevated_buttom.dart';
import '../../../core/resourses/widget/custom_text_button.dart';
import '../../../core/resourses/widget/custom_text_form_field.dart';
import '../../../core/routers.dart';
import '../../models/register_request.dart';



class Register extends StatefulWidget {
  const Register({super.key});
  static const routeName = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static const List<String> _defaultAvatars = [
    'assets/avatars/gamer(1).png',
    'assets/avatars/gamer(2).png',
    'assets/avatars/gamer(3).png',
  ];

  bool securePassword = true;
  bool secureConfirmPassword = true;

  String? _selectedImagePath = _defaultAvatars.first;

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


                SizedBox(
                  height: 120.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _defaultAvatars.sublist(0, 3).map((avatarPath) {
                      final isSelected = _selectedImagePath == avatarPath;
                      // تحديد حجم الأفاتار: 50.r للمختار، 40.r للآخرين
                      final radius = isSelected ? 50.r : 40.r;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImagePath = avatarPath;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            border: isSelected
                                ? Border.all(color: AppColors.yellow, width: 4.w)
                                : null,
                          ),
                          child: CircleAvatar(
                            radius: radius,
                            backgroundImage: AssetImage(avatarPath),
                            backgroundColor: Colors.grey[800],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // -----------------------------------------------------------------

                SizedBox(height: 30.h), // مسافة قبل حقول الإدخال

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

  void _onTogglePasswordIconClicked() {
    setState(() => securePassword = !securePassword);
  }

  void _onToggleConfirmPasswordIconClicked() {
    setState(() => secureConfirmPassword = !secureConfirmPassword);
  }

  void _register() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        UIUtils.showLoading(context,isDismissible: false);
        UserCredential userCredential= await FirebaseServices.register(RegisterRequest(email:_emailController.text,password: _passwordController.text ));

        UserModel user = UserModel(
          id: userCredential.user!.uid,
          name: _nameController.text,
          email: _emailController.text,
          imageUrl: _selectedImagePath, // حفظ مسار الأفاتار المختار
        );

        await FirebaseServices.addUserToFireStore(user);
        UIUtils.hideDialog(context);
        UIUtils.showToastMessage("Successfully Registration",Colors.green );
        Navigator.pushReplacementNamed(context,AppRoutes.login);

      }
      on FirebaseException catch (exception) {
        UIUtils.hideDialog(context);
        UIUtils.showToastMessage(exception.code, Colors.red);
      }
      catch(exception){
        UIUtils.hideDialog(context);
        UIUtils.showToastMessage("Failed to register",Colors.red );

      }

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
}*/
