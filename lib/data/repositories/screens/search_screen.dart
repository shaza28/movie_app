// lib/data/repositories/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:movie_app/core/resourses/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: AppColors.gray),
              hintText: 'Search movies...',
              hintStyle: TextStyle(color: AppColors.gray),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
            ),
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: AppColors.gray, size: 60),
            const SizedBox(height: 16),
            Text(
              'Search for movies',
              style: TextStyle(color: AppColors.white, fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Type in the search bar above',
              style: TextStyle(color: AppColors.gray, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
