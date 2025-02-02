import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach/core/utils/app_colors.dart';

class AppTheme {
  static var appTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bgColor,
      primaryColor: AppColors.widgetColor,
      colorScheme: const ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.widgetColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(size: 20.r, color: Colors.white),
        actionsIconTheme: IconThemeData(size: 20.r),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(iconSize: 24.r),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
      ),
      iconTheme: IconThemeData(size: 24.r),
      primaryIconTheme: IconThemeData(size: 24.r),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.widgetColor,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.widgetColor,
        unselectedItemColor: AppColors.titleColor,
      ));
}
