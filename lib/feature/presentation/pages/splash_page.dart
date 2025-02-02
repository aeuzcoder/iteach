import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_assets.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final _controller = Get.find<SplashController>();
  late AnimationController _animationController;
  late Animation<double> _shineAnimation;

  @override
  void initState() {
    super.initState();
    _controller.initTimer();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    _shineAnimation =
        Tween<double>(begin: -1.0, end: 2.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Center(
            child: ClipRRect(
              // Обрезаем границы
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200.w,
                    height: 100.h,
                    decoration:
                        // ignore: deprecated_member_use
                        BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            // ignore: deprecated_member_use
                            color: AppColors.grey.withOpacity(0.5)),
                  ),
                  AnimatedBuilder(
                    animation: _shineAnimation,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [
                              _shineAnimation.value - 0.3,
                              _shineAnimation.value,
                              _shineAnimation.value + 0.3
                            ],
                            colors: [
                              Colors.transparent,
                              // ignore: deprecated_member_use
                              Colors.white.withOpacity(0.4),
                              Colors.transparent,
                            ],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop, // Улучшает смешивание
                        child: Image.asset(
                          AppAssets.images.logo,
                          width: 180.w,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
