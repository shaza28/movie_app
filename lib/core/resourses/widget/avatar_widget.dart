import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final bool hasNotification;
  final VoidCallback? onTap;

  const AvatarWidget({
    Key? key,
    this.imageUrl,
    this.userName,
    this.size = 40,
    this.backgroundColor = const Color(0xFF282428),
    this.textColor = Colors.white,
    this.hasNotification = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          Container(
            width: size.w,
            height: size.h,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF4FA9FF),
                width: 1.5.w,
              ),
            ),
            child: _buildAvatarContent(),
          ),


          if (hasNotification)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 10.w,
                height: 10.h,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildAvatarContent() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: imageUrl!.startsWith('assets/')
            ? Image.asset(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildFallback(),
        )
            : Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildFallback(),
        ),
      );
    }

    return _buildFallback();
  }

  Widget _buildFallback() {
    return Center(
      child: userName != null && userName!.isNotEmpty
          ? Text(
        _getInitials(userName!),
        style: TextStyle(
          color: textColor,
          fontSize: size.w * 0.3,
          fontWeight: FontWeight.bold,
        ),
      )
          : Icon(
        Icons.person,
        color: textColor,
        size: size.w * 0.5,
      ),
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.trim().split(' ').where((part) => part.isNotEmpty).toList();

    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty) {
      // 3. إذا كان اسماً واحداً فقط
      return nameParts[0][0].toUpperCase();
    }
    return 'U';
  }
}