import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/resourses/app_colors.dart';
import '../../../core/resourses/app_images.dart';
import '../../../core/routers.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "/onboarding";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': AppImages.screenOne,
      'title': "Find Your Next\nFavorite Movie Here",
      'description': "Get access to a huge library of movies to suit all tastes.",
      'button': "Explore Now",
    },
    {
      'image': AppImages.screenTwo,
      'title': "Discover Movies",
      'description': "Explore a vast collection of movies in all qualities and genres.",
      'button': "Next",
    },
    {
      'image': AppImages.screenThree,
      'title': "Explore All Genres",
      'description': "Discover movies from every genre, in all available qualities.",
      'button': "Next",
    },
    {
      'image': AppImages.screenFour,
      'title': "Create Watchlists",
      'description': "Save movies to your watchlist to keep track of what you want to watch next.",
      'button': "Next",
    },
    {
      'image': AppImages.screenFive,
      'title': "Rate, Review, and Learn",
      'description': "Share your thoughts on the movies you've watched.",
      'button': "Next",
    },
    {
      'image': AppImages.screenSix,
      'title': "TIMEISTHEENEMY",
      'description': "Start Watching Now",
      'button': "Finish",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (_, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_pages[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              color: Colors.black.withOpacity(0.8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    _pages[_currentPage]['title']!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    _pages[_currentPage]['description']!,
                    style: TextStyle(color: AppColors.white, fontSize: 18.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                          (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? AppColors.yellow : AppColors.gray,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Column(
                    children: [

                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          child: Text(
                            _pages[_currentPage]['button']!,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      if (_currentPage > 0)
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              _pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.yellow),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              side: BorderSide(color: AppColors.yellow, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _nextPage() async {
    if (_currentPage == _pages.length - 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('seenOnboarding', true);
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }  }
}
