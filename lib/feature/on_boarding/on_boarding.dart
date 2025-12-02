import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/resourses/app_images.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "/onboarding";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'image': AppImages.screenOne,
      'title': "Find Your Next\nFavorite Movie Here",
      'description': "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      'button': "Explore Now",
    },
    {
      'image': AppImages.screenTwo,
      'title': "Discover Movies",
      'description': "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      'button': "Next",
    },
    {
      'image': AppImages.screenThree,
      'title': "Explore All Genres",
      'description': "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      'button': "Next",
    },
    {
      'image': AppImages.screenFour,
      'title': "Create Watchlists",
      'description': "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      'button': "Next",
    },
    {
      'image': AppImages.screenFive,
      'title': "Rate, Review, and Learn",
      'description': "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
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
          // خلفية الصفحة - الصورة الكبيرة
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_pages[index]['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // Bottom Sheet من تحت
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 320.h,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // العنوان والوصف
                    Column(
                      children: [
                        Text(
                          _pages[_currentPage]['title'],
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          _pages[_currentPage]['description'],
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[400],
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),


                    Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_pages.length, (index) {
                            return Container(
                              width: 8.w,
                              height: 8.h,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index ? Colors.red : Colors.grey[600],
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: 30.h),

                        // الزر
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPage == _pages.length - 1) {
                                Navigator.pushReplacementNamed(context, '/login');
                              } else {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              _pages[_currentPage]['button'],
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}