import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:iteach/core/errors/exception.dart';
import 'package:iteach/core/network/api_constants.dart';
import 'package:iteach/core/services/network_info.dart';
import 'package:iteach/feature/data/datasources/network/network_service.dart';
import 'package:iteach/feature/data/models/attendance_model.dart';
import 'package:iteach/feature/data/models/attendance_stat_model.dart';
import 'package:iteach/feature/data/models/attendence_detail_model.dart';
import 'package:iteach/feature/data/models/course_model.dart';
import 'package:iteach/feature/data/models/login_model.dart';
import 'package:iteach/feature/data/models/student_nodel.dart';
import 'package:iteach/feature/data/models/user_model.dart';
import 'package:iteach/feature/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final NetworkInfo networkInfo;
  UserRepoImpl({required this.networkInfo});
  @override
  Future<Either<String, LoginModel>> login(
      {required String username, required String password}) async {
    try {
      final response = await NetworkService.POST(
        ApiConstants.TOKEN,
        {
          'username': username,
          'password': password,
        },
        isAuth: true,
      );
      final resultJson = jsonDecode(response!);

      final result = LoginModel.fromJson(resultJson);

      return Right(result);
    } on InvalidInputException {
      return Left('Login yoki parolda xatolik');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> internetInfo() async {
    final bool result = await networkInfo.isConnected;
    log('INTERNET: $result');
    if (result) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Either<String, String>> refreshToken(String currentToken) async {
    try {
      final response = await NetworkService.POST(
          ApiConstants.REFRESH_TOKEN, NetworkService.paramsEmpty());
      final resultJson = jsonDecode(response!);
      String result = resultJson['access_token'];
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> addCourse(CourseModel course) async {
    try {
      var response = await NetworkService.POST(
          ApiConstants.COURSE_CREATE, course.toJson());
      var resultJson = jsonDecode(response ?? '');
      return Right(resultJson['message'] ?? resultJson.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> addStudent(StudentModel student) async {
    try {
      var response = await NetworkService.POST(
          ApiConstants.COURSE_CREATE, student.toJson());
      var resultJson = jsonDecode(response ?? '');
      return Right(resultJson['message'] ?? resultJson.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> addAttendance(
      AttendanceModel attendance) async {
    try {
      var response = await NetworkService.POST(
          ApiConstants.ATTENDANCE_CREATE, attendance.toJson());
      var resultJson = jsonDecode(response ?? '');
      return Right(resultJson['message'] ?? resultJson.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteAttendance(int attendanceId) async {
    try {
      var response = await NetworkService.DEL(
        ApiConstants.ATTENDANCE_DELETE,
        params: {"attendance_id": attendanceId.toString()},
      );

      var resultJson = jsonDecode(response ?? '');
      return Right(resultJson ?? resultJson.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteCourse(int courseId) async {
    try {
      var response = await NetworkService.DEL(
        ApiConstants.COURSE_DELETE,
        params: {"course_id": courseId.toString()},
      );

      var resultJson = jsonDecode(response ?? '');
      return Right(resultJson ?? resultJson.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteStudent(int studentId) async {
    try {
      var response = await NetworkService.DEL(
        ApiConstants.STUDENT_DELETE,
        params: {"student_id": studentId.toString()},
      );

      var resultJson = jsonDecode(response ?? '');
      return Right(resultJson ?? resultJson.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<AttendanceDetailModel>>> getAttendance(
      {int? courseId, int? studentId, String? today}) async {
    try {
      var response = await NetworkService.GET(
        ApiConstants.ATTENDANCE_GET_ATTENDANCE,
        {
          if (courseId != null) "course_id": courseId.toString(),
          if (studentId != null) "student_id": studentId.toString(),
          if (today != null) "attendance_date": today.toString()
        },
      );
      var resultJson = jsonDecode(response ?? '');
      List<AttendanceDetailModel> result = resultJson
          .map<AttendanceDetailModel>(
              (table) => AttendanceDetailModel.fromJson(table))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<AttendanceStatModel>>> getAttendanceStat(
      int? studentId) async {
    try {
      var response = await NetworkService.GET(
        ApiConstants.ATTENDANCE_GET_ATTENDANCE_STATISTICS,
        {
          if (studentId != null) "student_id": studentId.toString(),
        },
      );
      var resultJson = jsonDecode(response ?? '');
      List<AttendanceStatModel> result = resultJson
          .map<AttendanceStatModel>(
              (table) => AttendanceStatModel.fromJson(table))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CourseModel>>> getCourses() async {
    try {
      var response = await NetworkService.GET(
        ApiConstants.COURSE_TEACHER_OWN_GROUP,
        NetworkService.paramsEmpty(),
      );
      var resultJson = jsonDecode(response ?? '');
      List<CourseModel> result = resultJson
          .map<CourseModel>((table) => CourseModel.fromJson(table))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> getProfile() async {
    try {
      var response = await NetworkService.GET(
          ApiConstants.USER_GET_OWN, NetworkService.paramsEmpty());
      var resultJson = jsonDecode(response!);
      UserModel result = UserModel.fromJson(resultJson);

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StudentModel>>> getStudents(int? courseId) async {
    try {
      var response = await NetworkService.GET(
        ApiConstants.STUDENT_GET_OWN_STUDENTS,
        {
          if (courseId != null) "course_id": courseId.toString(),
        },
      );
      var resultJson = jsonDecode(response ?? '');
      List<StudentModel> result = resultJson
          .map<StudentModel>((table) => StudentModel.fromJson(table))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadImageOnCourse(
      {required String path, required int courseId}) async {
    try {
      var response = await NetworkService.POST(
          ApiConstants.COURSE_UPLOAD_IMAGE, {"ident": courseId.toString()},
          path: path);
      var result = jsonDecode(response ?? '');
      return Right(result['message'] ?? result.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadImageOnProfile(String path) async {
    try {
      var response = await NetworkService.POST(
          ApiConstants.USER_UPLOAD_IMAGE, NetworkService.paramsEmpty(),
          path: path);
      var result = jsonDecode(response ?? '');
      log(result.toString());
      return Right(result['message']);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateCourse(
      {required int courseId, required Map<String, String> body}) async {
    try {
      var response = await NetworkService.PUT(ApiConstants.COURSE_UPDATE,
          body: body, params: {"ident": courseId.toString()});
      var result = jsonDecode(response ?? '');
      return Right(result['message'] ?? 'null');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateProfile(Map<String, String> body) async {
    try {
      var response =
          await NetworkService.PUT(ApiConstants.USER_UPDATE_OWN, body: body);
      var result = jsonDecode(response ?? '');
      return Right(result['message'] ?? 'null');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateAttendance(
      {required int attendaceId, required Map<String, String> body}) async {
    try {
      var response = await NetworkService.PUT(ApiConstants.ATTENDANCE_UPDATE,
          body: body, params: {"attendance_id": attendaceId.toString()});
      var result = jsonDecode(response ?? '');
      return Right(result['message'] ?? 'null');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateStudent(
      {required int studentId, required Map<String, String> body}) async {
    try {
      var response = await NetworkService.PUT(ApiConstants.STUDENT_UPDATE,
          body: body, params: {"ident": studentId.toString()});
      var result = jsonDecode(response ?? '');
      return Right(result['message'] ?? 'null');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
