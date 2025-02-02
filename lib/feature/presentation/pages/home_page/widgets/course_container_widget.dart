import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_assets.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/core/utils/app_functions.dart';
import 'package:iteach/feature/data/models/course_model.dart';

class CourseContainerWidget extends StatelessWidget {
  const CourseContainerWidget({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: GestureDetector(
        onTap: () => Get.toNamed('/course', arguments: course.id),
        child: Container(
          height: 100.h,
          decoration: BoxDecoration(
            color: AppColors.wGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                //IMAGE
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(AppAssets.images.logoCourse)),
                ),

                SizedBox(width: 8.w),

                //COLUMN TEXTS
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //NAME
                    Text(
                      course.name,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),

                    //PERIOD
                    Text(
                      'Davomiyligi: ${course.period} oy',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),

                    //PRICE
                    Text(
                      'Narxi: ${AppFunctions.formattingPrice(course.price)}',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),

                //SPACER
                Spacer(),

                //PERIOD
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: AppColors.widgetColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      course.level.toString(),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.wGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
