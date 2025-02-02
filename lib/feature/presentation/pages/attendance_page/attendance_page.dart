import 'package:flutter/material.dart';
import 'package:iteach/core/utils/app_colors.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(
          child: Scaffold(
        body: Center(
          child: Text('ATTENDANCE PAGE'),
        ),
      )),
    );
  }
}
