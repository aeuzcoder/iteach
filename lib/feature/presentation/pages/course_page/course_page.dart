import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/course_controlller.dart';
import 'package:iteach/feature/presentation/pages/course_page/widgets/student_container_widget.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(child: GetBuilder<CourseControlller>(
        builder: (controller) {
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: GestureDetector(
                onTap: () async {
                  await controller.setAttendances();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0.h),
                  child: Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: AppColors.widgetColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: controller.isLoading2
                                ? CircularProgressIndicator(
                                    color: AppColors.bgColor,
                                    strokeWidth: 2,
                                  )
                                : Text(
                                    controller.isFirstAttendace
                                        ? 'Saqlash'
                                        : 'O\'zgartirish',
                                    style: TextStyle(
                                      color: AppColors.bgColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      )),
                ),
              ),
              appBar: AppBar(
                centerTitle: true,
                title: !controller.isLoading
                    ? Text(
                        controller.isFirstAttendace
                            ? 'Davomat olinmadi'
                            : 'Davomat olingan',
                        style: TextStyle(
                          color: AppColors.titleColor,
                          fontSize: 20.sp,
                        ),
                      )
                    : SizedBox(),
                backgroundColor: AppColors.bgColor,
              ),
              body: controller.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.widgetColor,
                        strokeWidth: 2,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.students.length,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  // ignore: deprecated_member_use
                                  color: AppColors.titleColor.withOpacity(0.8),
                                );
                              },
                              itemBuilder: (context, index) {
                                if (controller.students.isEmpty) {
                                  return SizedBox();
                                }
                                final student = controller.students[index];

                                return StudentContainerWidget(
                                  student: student,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ));
        },
      )),
    );
  }
}
