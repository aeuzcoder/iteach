import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/main_controller.dart';
import 'package:iteach/feature/presentation/pages/parts/teacher/attendance_page/attendance_page.dart';
import 'package:iteach/feature/presentation/pages/parts/teacher/home_page/home_page.dart';
import 'package:iteach/feature/presentation/pages/parts/teacher/profile_page.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: [
            const HomePage(),
            const AttendancePage(),
            const ProfilePage(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            selectedItemColor: AppColors.titleColor,
            unselectedItemColor: AppColors.widgetColor,
            backgroundColor: AppColors.bgColor,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex,
            onTap: controller.onChange,
            items: [
              _navItem(Icons.home, 'Kurslar'),
              _navItem(Icons.border_color_outlined, 'Statistika'),
              _navItem(Icons.person, 'Profile'),
            ],
          ),
        ),
      );
    });
  }

  _navItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: AppColors.widgetColor,
      ),
      activeIcon: Icon(
        icon,
        color: AppColors.titleColor,
      ),
      label: label,
    );
  }
}
