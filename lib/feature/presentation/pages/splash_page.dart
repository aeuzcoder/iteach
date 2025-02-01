import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    _controller.initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bgColor,
    );
  }
}
