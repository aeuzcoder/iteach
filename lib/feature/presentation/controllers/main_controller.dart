import 'package:flutter/material.dart';
import 'package:iteach/feature/presentation/controllers/base_controller.dart';

class MainController extends BaseController {
  final pageController = PageController();
  int currentIndex = 0;

  void onChange(int index) {
    pageController.jumpToPage(index);
    currentIndex = index;
    update();
  }

  @override
  void onClose() {
    pageController.dispose(); // Удаляем контроллер при закрытии
    super.onClose();
  }
}
