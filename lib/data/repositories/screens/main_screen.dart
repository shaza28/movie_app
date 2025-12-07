// lib/data/repositories/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:movie_app/core/resourses/app_colors.dart';
import 'package:movie_app/data/repositories/screens/home_screen.dart';
import 'package:movie_app/data/repositories/screens/search_screen.dart';
import 'package:movie_app/data/repositories/screens/browse_screen.dart';
import 'package:movie_app/data/repositories/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BrowseScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.black,
          border: Border(top: BorderSide(color: AppColors.darkGray, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.yellow,
          unselectedItemColor: AppColors.gray,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 26),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 26),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore, size: 26),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 26),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
