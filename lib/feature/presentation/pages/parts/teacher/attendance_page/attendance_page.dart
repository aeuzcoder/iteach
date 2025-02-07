import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/attendance_controller.dart';
import 'package:iteach/feature/presentation/pages/parts/teacher/attendance_page/widgets/student_stat_widget.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(
        child: GetBuilder<AttendanceController>(
          builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Statistika',
                  style: TextStyle(
                    color: AppColors.titleColor,
                    fontSize: 20.sp,
                  ),
                ),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                              child: ListView.separated(
                                itemCount: controller.attenStats.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    // ignore: deprecated_member_use
                                    color: AppColors.titleColor
                                        // ignore: deprecated_member_use
                                        .withOpacity(0.4),
                                  );
                                },
                                itemBuilder: (context, index) {
                                  if (controller.attenStats.isEmpty) {
                                    return SizedBox();
                                  }
                                  final stat = controller.attenStats[index];

                                  return StudentStatWidget(
                                    stat: stat,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            )
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
