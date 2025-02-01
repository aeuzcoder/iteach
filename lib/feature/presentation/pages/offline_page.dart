import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach/core/utils/app_colors.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text(
              'Internet yo\'q',
              style: TextStyle(color: AppColors.widgetColor, fontSize: 32.sp),
            ),
          ),
        ),
      ),
    );
  }
}
