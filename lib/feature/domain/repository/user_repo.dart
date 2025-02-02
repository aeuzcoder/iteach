import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:iteach/feature/data/models/attendance_model.dart';
import 'package:iteach/feature/data/models/attendance_stat_model.dart';
import 'package:iteach/feature/data/models/attendence_detail_model.dart';
import 'package:iteach/feature/data/models/course_model.dart';
import 'package:iteach/feature/data/models/login_model.dart';
import 'package:iteach/feature/data/models/student_nodel.dart';
import 'package:iteach/feature/data/models/user_model.dart';

abstract class UserRepo {
  /*         TOKEN           */
  //LOGIN
  Future<Either<String, LoginModel>> login(
      {required String username, required String password});

  //REFRESH TOKEN
  Future<Either<String, String>> refreshToken(String currentToken);

  /*        PROFILE         */
  //GET PROFILE
  Future<Either<String, UserModel>> getProfile();

  //CHANGE PROFILE
  Future<Either<String, String>> updateProfile(Map<String, String> body);

  //UPLOAD IMAGE ON PROFILE
  Future<Either<String, String>> uploadImageOnProfile(String path);

  /*        COURSE         */
  //GET COURSES
  Future<Either<String, List<CourseModel>>> getCourses();

  //ADD COURSE
  Future<Either<String, String>> addCourse(CourseModel course);

  //CHANGE COURSE
  Future<Either<String, String>> updateCourse(
      {required int courseId, required Map<String, String> body});

  //DELETE COURSE
  Future<Either<String, String>> deleteCourse(int courseId);

  //UPLOAD IMAGE ON COURSE
  Future<Either<String, String>> uploadImageOnCourse(
      {required String path, required int courseId});

  /*        STUDENTS          */
  //GET STUDENTS
  Future<Either<String, List<StudentModel>>> getStudents(int? courseId);

  //ADD STUDENT
  Future<Either<String, String>> addStudent(StudentModel student);

  //CHANGE STUDENT
  Future<Either<String, String>> updateStudent(
      {required int studentId, required Map<String, String> body});

  //DELETE STUDENT
  Future<Either<String, String>> deleteStudent(int studentId);

  /*        ATTENDANCE         */
  //GET ATTENDANCE STATISTICS
  Future<Either<String, List<AttendanceStatModel>>> getAttendanceStat(
      int? studentId);

  //GET ATTENDANCE
  Future<Either<String, List<AttendanceDetailModel>>> getAttendance(
      {int? courseId, int? studentId, String? today});

  //SET ATTENDANCE
  Future<Either<String, String>> addAttendance(AttendanceModel attendance);

  //CHANGE ATTENDANCE
  Future<Either<String, String>> updateAttendance(
      {required int attendaceId, required Map<String, String> body});

  //DELETE ATTENDANCE
  Future<Either<String, String>> deleteAttendance(int attendanceId);

  /*        CORE         */
  //CHECK INTERNET
  Future<bool> internetInfo();
}
