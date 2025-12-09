import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/UI_Utils.dart';
import 'package:movie_app/core/resourses/app_colors.dart';
import 'package:movie_app/feature/models/user_model.dart';
// 💡 إزالة استيرادات Firebase:
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:movie_app/firebase/firebase_service.dart';

// 💡 استيراد خدمات الـ API والتخزين الجديدة


import '../../../core/resourses/app_images.dart';
import '../../../core/resourses/widget/custom_text_form_field.dart';
import '../../../core/routers.dart';
import '../../../core/services/rest_api_services.dart';
import '../../../core/services/storage_service.dart';
// 💡 إزالة: import 'package:movie_app/feature/models/login_request.dart';


class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool securePassword = true;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 200.w,
                  height: 200.h,
                ),
                SizedBox(height: 40.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgetPassword);
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Login Button
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have Account?",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.register);
                          },
                          child: Text(
                            "Create One",
                            style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    // OR Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    // Login With Google Button (تم إزالة الوظيفة)
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        // 💡 تم تعطيل وظيفة Google Sign-In هنا
                        onPressed: (){
                          UIUtils.showToastMessage("Google Sign-In disabled for REST API mode", Colors.blue);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.googleIcon,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Login With Google",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 💡 تم حذف دالة signInWithGoogle بالكامل
  // Future<void>signInWithGoogle()async{...}

  void _onTogglePasswordIconClicked() {
    setState(() {
      securePassword = !securePassword;
    });
  }



  void _login() async{
    if (_formKey.currentState?.validate() == true) {
      try
      {
        UIUtils.showLoading(context,isDismissible:false );

        // 💡 استدعاء خدمة الـ REST API الجديدة
        UserModel loggedInUser = await RestApiServices.login(
            _emailController.text,
            _passwordController.text
        );

        // 💡 حفظ الـ Token (ضروري لتوثيق الطلبات اللاحقة)
        if(loggedInUser.token != null) {
          await StorageService.saveToken(loggedInUser.token!);
        }

        // 💡 تعيين المستخدم الحالي
        UserModel.currentUser = loggedInUser;

        UIUtils.hideDialog(context);
        UIUtils.showToastMessage("User Logged-In Successfully",Colors.green);
        Navigator.pushReplacementNamed(context,AppRoutes.homeScreen);
      }
      // 💡 تعديل معالجة الخطأ لاستقبال الاستثناء المرمي من RestApiServices
      on Exception catch(exception){
        UIUtils.hideDialog(context);
        // عرض رسالة الخطأ النظيفة
        UIUtils.showToastMessage(exception.toString().replaceFirst('Exception: ', ''),Colors.red);
      }
      catch(exception){
        UIUtils.hideDialog(context);
        UIUtils.showToastMessage("Failed to login",Colors.red);
      }
    }
  }

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
}

/*
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/core/UI_Utils.dart';
import 'package:movie_app/core/resourses/app_colors.dart';
import 'package:movie_app/feature/models/login_request.dart';
import 'package:movie_app/feature/models/user_model.dart';
import 'package:movie_app/firebase/firebase_service.dart';
import '../../../core/resourses/app_images.dart';
import '../../../core/resourses/widget/custom_text_form_field.dart';
import '../../../core/routers.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool securePassword = true;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 200.w,
                  height: 200.h,
                ),
                SizedBox(height: 40.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgetPassword);
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Login Button
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have Account?",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.register);
                          },
                          child: Text(
                            "Create One",
                            style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    // OR Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    // Login With Google Button
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){ signInWithGoogle();
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.homeScreen);},

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.googleIcon,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Login With Google",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),






                    SizedBox(height: 30.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void>signInWithGoogle()async{
try{
  final GoogleSignIn googleSignIn =GoogleSignIn.instance ;
   await googleSignIn.initialize(
     serverClientId:"698466243790-uikh4ma096k5geepmo3us1mad98o8uv3.apps.googleusercontent.com"
   );


  final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
if(googleUser==null)return;
  final GoogleSignInAuthentication googleAuth = googleUser.authentication;
  final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
 UserCredential firebaseUser=await FirebaseAuth.instance.signInWithCredential(credential);
  UserModel finalUser = UserModel(
    id: firebaseUser.user?.uid?? " ",
    email:firebaseUser.user?.email ??"No email provided", name: firebaseUser.user?.displayName ?? "No name provided"
  );
  
   await FirebaseServices.addUserToFireStore(finalUser);

}catch(exception){
  log(exception.toString());
}
  }

  void _onTogglePasswordIconClicked() {
    setState(() {
      securePassword = !securePassword;
    });
  }



  void _login() async{
    if (_formKey.currentState?.validate() == true) {
      try
      {
       UIUtils.showLoading(context,isDismissible:false );
       UserCredential userCredential =await FirebaseServices.login(LoginRequest(email: _emailController.text,password:_passwordController.text));
       UserModel.currentUser= await FirebaseServices.getUserFromFireStore(userCredential.user!.uid);
       UIUtils.hideDialog(context);
       UIUtils.showToastMessage("User Logged-In Successfully",Colors.green);
       Navigator.pushReplacementNamed(context,AppRoutes.homeScreen);
     }on FirebaseAuthException catch(exception){
        UIUtils.hideDialog(context);
        UIUtils.showToastMessage("Invalid email or password",Colors.red);
      }catch(exception){
        UIUtils.hideDialog(context);
        UIUtils.showToastMessage("Failed to login",Colors.red);
      }
    }
    }
  }

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














*/
