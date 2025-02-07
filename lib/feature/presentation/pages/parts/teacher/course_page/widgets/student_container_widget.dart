import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/core/utils/app_functions.dart';
import 'package:iteach/feature/data/models/student_nodel.dart';
import 'package:iteach/feature/presentation/controllers/course_controlller.dart';

class StudentContainerWidget extends StatefulWidget {
  const StudentContainerWidget({super.key, required this.student});
  final StudentModel student;

  @override
  State<StudentContainerWidget> createState() => _StudentContainerWidgetState();
}

class _StudentContainerWidgetState extends State<StudentContainerWidget> {
  bool check = false;
  final controllerH = Get.find<CourseControlller>();
  @override
  void initState() {
    super.initState();
    check = controllerH.isHaveFromId(widget.student.id!);
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //NAME
                Text(
                  widget.student.fullName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1,
                    color: AppColors.titleColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 2.h),

                // //DATE
                // Text(
                //   AppFunctions.formatDate(widget.student.startedDate),
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     height: 1,
                //     color: AppColors.white,
                //     fontSize: 16.sp,
                //   ),
                // ),
                SizedBox(height: 4.h),

                //PHONE
                Text(
                  AppFunctions.formatPhone(
                      widget.student.phoneNumber.toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1,
                    color: AppColors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  check = !check;
                });
                controllerH.changeFromId(state: check, id: widget.student.id!);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.widgetColor, width: 2),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.check,
                  size: 32,
                  color: check ? AppColors.widgetColor : AppColors.bgColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
