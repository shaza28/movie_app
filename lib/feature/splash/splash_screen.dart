import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resourses/app_colors.dart';
import '../../../core/resourses/app_images.dart';
import '../../../core/routers.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  void _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (seenOnboarding) {
      Navigator.pushReplacementNamed(
        context,
        FirebaseAuth.instance.currentUser == null
            ? AppRoutes.login
            : AppRoutes.homeScreen,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onBoarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            children: [
              Spacer(),
              Image.asset(AppImages.logo, width: 150.w, height: 150.h),
              Spacer(),
              Center(
                child: Image.asset(
                  AppImages.branding,
                  width: 200.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
