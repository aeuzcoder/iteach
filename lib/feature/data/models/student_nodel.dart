class StudentModel {
  int? id;
  final int phoneNumber;
  final String fullName;
  final int courseId;
  final String startedDate;

  StudentModel({
    required this.id,
    required this.phoneNumber,
    required this.fullName,
    required this.courseId,
    required this.startedDate,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      phoneNumber: json['phone_number'],
      fullName: json['full_name'],
      courseId: json['course_id'],
      startedDate: json['started_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'phone_number': phoneNumber,
      'full_name': fullName,
      'course_id': courseId,
      'started_date': startedDate,
    };
  }
}
