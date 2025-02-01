class AttendanceStatModel {
  final int studentId;
  final String studentName;
  final int totalClasses;
  final int presentClasses;
  final int absentClasses;
  final int attendancePercentage;

  AttendanceStatModel({
    required this.studentId,
    required this.studentName,
    required this.totalClasses,
    required this.presentClasses,
    required this.absentClasses,
    required this.attendancePercentage,
  });

  // Метод для преобразования JSON в объект AttendanceModel
  factory AttendanceStatModel.fromJson(Map<String, dynamic> json) {
    return AttendanceStatModel(
      studentId: json['student_id'],
      studentName: json['student_name'],
      totalClasses: json['total_classes'],
      presentClasses: json['present_classes'],
      absentClasses: json['absent_classes'],
      attendancePercentage: json['attendance_percentage'],
    );
  }

  // Метод для преобразования объекта AttendanceModel в JSON
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'student_name': studentName,
      'total_classes': totalClasses,
      'present_classes': presentClasses,
      'absent_classes': absentClasses,
      'attendance_percentage': attendancePercentage,
    };
  }
}
