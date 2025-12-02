import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/resourses/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.keyboardType,
    this.isSecure = false,
    this.validator,
    this.controller,
    this.maxLines = 1,
    this.onChanged, // <- أضفنا هذا
  });

  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool isSecure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int maxLines;
  final void Function(String)? onChanged; // <- هنا

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      obscureText: isSecure,
      keyboardType: keyboardType,
      style: TextStyle(
        color: AppColors.white,
        fontSize: 14.sp,
      ),
      onChanged: onChanged, // <- هنا
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.white.withOpacity(0.5),
          fontSize: 14.sp,
        ),
        prefixIcon: prefixIcon != null
            ? IconTheme(
          data: IconThemeData(
            color: AppColors.white,
            size: 20.sp,
          ),
          child: prefixIcon!,
        )
            : null,
        suffixIcon: suffixIcon != null
            ? IconTheme(
          data: IconThemeData(
            color: AppColors.white,
            size: 20.sp,
          ),
          child: suffixIcon!,
        )
            : null,
        filled: true,
        fillColor: AppColors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: AppColors.yellow,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: AppColors.yellow,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
      ),
    );
  }
}
