class AttendanceModel {
  final String date;
  final int studentId;
  final int courseId;
  final bool status;

  AttendanceModel({
    required this.date,
    required this.studentId,
    required this.courseId,
    required this.status,
  });

  // Метод для преобразования JSON в объект Attendance
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      date: json['date'],
      studentId: json['student_id'],
      courseId: json['course_id'],
      status: json['status'],
    );
  }

  // Метод для преобразования объекта Attendance в JSON
  Map<String, String> toJson() {
    return {
      'date': date,
      'student_id': studentId.toString(),
      'course_id': courseId.toString(),
      'status': status.toString(),
    };
  }
}
