// lib/data/repositories/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:movie_app/core/resourses/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text('Profile', style: TextStyle(color: AppColors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.yellow, width: 3),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // User Name
            const Text(
              'Movie Lover',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Email
            Text(
              'user@example.com',
              style: TextStyle(color: AppColors.gray, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Menu Items
            _buildMenuItem(Icons.bookmark, 'My Watchlist'),
            _buildMenuItem(Icons.history, 'Watch History'),
            _buildMenuItem(Icons.settings, 'Settings'),
            _buildMenuItem(Icons.help, 'Help & Support'),
            _buildMenuItem(Icons.logout, 'Logout'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.yellow),
      title: Text(title, style: const TextStyle(color: AppColors.white)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.gray),
      onTap: () {},
    );
  }
}
