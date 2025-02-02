import 'dart:developer';

import 'package:iteach/feature/data/models/course_model.dart';
import 'package:iteach/feature/presentation/controllers/base_controller.dart';

class HomeController extends BaseController {
  late List<CourseModel> courses;
  @override
  void onInit() async {
    super.onInit();
    changeLoading(true);
    courses = await getCourses();
    changeLoading(false);
  }

  Future<List<CourseModel>> getCourses() async {
    final result = await userRepo.getCourses();
    return result.fold((error) {
      log("ERROR(getCourses): $error");
      changeError(true, text: error);
      return [];
    }, (courses) {
      return courses;
    });
  }
}
