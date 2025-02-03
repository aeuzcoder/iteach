import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/data/models/attendance_stat_model.dart';

class StudentStatWidget extends StatelessWidget {
  const StudentStatWidget({super.key, required this.stat});
  final AttendanceStatModel stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.bgColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.w),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.widgetColor, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Icons.person_outline_rounded,
                size: 32,
                color: AppColors.widgetColor,
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //NAME
                Text(
                  stat.studentName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1,
                    color: AppColors.titleColor,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 42.w,
                  height: 42.h,
                  child: CircularProgressIndicator(
                    value: stat.attendancePercentage / 100,
                    color: AppColors.blue,
                    strokeWidth: 3,
                  ),
                ),
                Text(
                  "${stat.attendancePercentage.toInt()}%",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
