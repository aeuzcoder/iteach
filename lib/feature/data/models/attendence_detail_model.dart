import 'package:iteach/feature/data/models/student_nodel.dart';

class AttendanceDetailModel {
  final int id;
  final int courseId;
  final String date;
  final int studentId;
  final bool status;
  final StudentModel student;

  AttendanceDetailModel({
    required this.id,
    required this.courseId,
    required this.date,
    required this.studentId,
    required this.status,
    required this.student,
  });

  // Метод для преобразования JSON в объект AttendanceDetailModel
  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailModel(
      id: json['id'],
      courseId: json['course_id'],
      date: json['date'],
      studentId: json['student_id'],
      status: json['status'],
      student: StudentModel.fromJson(json['student']),
    );
  }

  // Метод для преобразования объекта AttendanceDetailModel в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'date': date,
      'student_id': studentId,
      'status': status,
      'student': student.toJson(),
    };
  }
}
