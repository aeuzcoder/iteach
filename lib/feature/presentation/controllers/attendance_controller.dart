import 'dart:developer';

import 'package:iteach/feature/data/models/attendance_stat_model.dart';
import 'package:iteach/feature/presentation/controllers/base_controller.dart';

class AttendanceController extends BaseController {
  late List<AttendanceStatModel> attenStats;
  @override
  void onInit() async {
    super.onInit();
    changeLoading(true);
    attenStats = await getStat(null);
    changeLoading(false);
  }

  Future<List<AttendanceStatModel>> getStat(int? id) async {
    var response = await userRepo.getAttendanceStat(id);
    return response.fold((error) {
      changeError(true, text: error);
      log("ERROR(getStat): $error");
      return [];
    }, (stat) {
      return stat;
    });
  }
}
