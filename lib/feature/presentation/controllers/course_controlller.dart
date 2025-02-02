import 'dart:developer';

import 'package:get/get.dart';
import 'package:iteach/core/utils/app_functions.dart';
import 'package:iteach/feature/data/models/attendance_model.dart';
import 'package:iteach/feature/data/models/attendence_detail_model.dart';
import 'package:iteach/feature/data/models/student_nodel.dart';
import 'package:iteach/feature/presentation/controllers/base_controller.dart';

class CourseControlller extends BaseController {
  late final int courseId;
  late final List<StudentModel> students;
  late List<AttendanceDetailModel> currentAttendances;
  bool isLoading2 = false;
  bool isFirstAttendace = true;
  Map<int, bool> attendances = {};
  @override
  void onInit() async {
    super.onInit();
    changeLoading(true);
    courseId = await Get.arguments;
    students = await getStudents(courseId);
    currentAttendances = await getAttendace();
    if (students.isNotEmpty) {
      if (currentAttendances.isEmpty) {
        for (var student in students) {
          attendances[student.id!] = false;
        }
      } else {
        isFirstAttendace = false;
        for (var student in students) {
          for (var attendance in currentAttendances) {
            if (attendance.student.id == student.id) {
              attendances[student.id!] = attendance.status;
            } else {
              continue;
            }
          }
        }
      }
    }

    changeLoading(false);
  }

  void changeLoading2(bool state) {
    isLoading2 = state;
    update();
  }

  void changeFromId({required bool state, required int id}) {
    attendances[id] = state;
    log(attendances.toString());
    update();
  }

  bool isHaveFromId(int id) {
    if (attendances.containsKey(id)) {
      return attendances[id]!;
    } else {
      return false;
    }
  }

  List<AttendanceModel> getModel() {
    List<AttendanceModel> result = [];
    for (var attendance in attendances.entries) {
      result.add(AttendanceModel(
          date: AppFunctions.today(),
          studentId: attendance.key,
          courseId: courseId,
          status: attendance.value));
    }

    return result;
  }

  Future<void> setAttendances() async {
    if (isFirstAttendace) {
      changeLoading2(true);
      final attendanceModels = getModel();
      for (var attendance in attendanceModels) {
        var response = await userRepo.addAttendance(attendance);
        response.fold((error) {
          changeError(true, text: error);
          log('ERROR(${attendance.studentId}): $error');
          changeLoading2(false);
        }, (result) {
          log('RESULT(${attendance.studentId}): $result');
          isFirstAttendace = false;
          changeLoading2(false);

          return result;
        });
      }
    } else {
      changeLoading2(true);
      final attendanceModels = getModel();
      for (var attendance in attendanceModels) {
        final attendanceId = attendenceIdFromId(attendance.studentId);
        if (attendanceId == null) {
          continue;
        }
        var response = await userRepo.updateAttendance(
            body: attendance.toJson(), attendaceId: attendanceId);
        response.fold((error) {
          changeError(true, text: error);
          log('ERROR(${attendance.studentId}): $error');
          changeLoading2(false);
        }, (result) {
          log('RESULT(${attendance.studentId}): $result');
          isFirstAttendace = false;
          changeLoading2(false);

          return result;
        });
      }
    }
  }

  int? attendenceIdFromId(int id) {
    for (var att in currentAttendances) {
      if (att.student.id == id) {
        return att.id;
      }
    }
    return null;
  }

  Future<List<AttendanceDetailModel>> getAttendace() async {
    var response = await userRepo.getAttendance(
        courseId: courseId, today: AppFunctions.today());

    return response.fold((error) {
      changeError(true, text: error);
      log('ERROR: $error');
      return [];
    }, (result) {
      log('RESULT: $result');

      return result;
    });
  }

  Future<List<StudentModel>> getStudents(int id) async {
    var result = await userRepo.getStudents(id);
    return result.fold((error) {
      log('ERROR(getStudents): $error');
      return [];
    }, (students) {
      return students;
    });
  }
}
