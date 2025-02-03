import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/home_controller.dart';
import 'package:iteach/feature/presentation/pages/home_page/widgets/course_container_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(
        child: Scaffold(
          //APPBAR
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Home',
              style: TextStyle(
                color: AppColors.titleColor,
                fontSize: 20.sp,
              ),
            ),
            backgroundColor: AppColors.bgColor,
          ),

          //BODY
          body: GetBuilder<HomeController>(
            builder: (controller) {
              //LOADING
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.widgetColor,
                    strokeWidth: 2,
                  ),
                );
              }

              //LOADED
              else {
                //MAIN COLUMN
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //BUILDER
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.courses.length,
                        itemBuilder: (context, index) {
                          final course = controller.courses[index];

                          return CourseContainerWidget(course: course);
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
