// lib/data/repositories/screens/browse_screen.dart
import 'package:flutter/material.dart';
import 'package:movie_app/core/resourses/app_colors.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genres = [
      'Action',
      'Adventure',
      'Comedy',
      'Drama',
      'Horror',
      'Romance',
      'Sci-Fi',
      'Thriller',
      'Fantasy',
      'Animation',
      'Crime',
      'Mystery',
    ];

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text('Browse', style: TextStyle(color: AppColors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: genres.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.darkGray,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.yellow),
              ),
              child: Center(
                child: Text(
                  genres[index],
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
