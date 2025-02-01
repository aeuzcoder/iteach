// ignore_for_file: constant_identifier_names

class ApiConstants {
  //BASE URL
  static const String BASE_URL = 'iteachsystem.uz';

  //APIS
  static const String REFRESH_TOKEN = '/refresh_token';
  static const String TOKEN = '/token';

  //USER
  static const String USER_GET_OWN = '/user/get_own';
  static const String USER_UPLOAD_IMAGE = 'user/upload-image';
  static const String USER_UPDATE_OWN = 'user/update_own';

  //COURSE
  static const String COURSE_TEACHER_OWN_GROUP = '/course/teacher_own_group';
  static const String COURSE_CREATE = '/course/create';
  static const String COURSE_UPLOAD_IMAGE = '/course/upload-image';
  static const String COURSE_UPDATE = '/course/update';
  static const String COURSE_DELETE = '/course/delete';

  //STUDENT
  static const String STUDENT_GET_OWN_STUDENTS = '/student/get_own_students';
  static const String STUDENT_CREATE = '/student/create';
  static const String STUDENT_UPDATE = '/student/update';
  static const String STUDENT_DELETE = '/student/delete';

  //ATTENDANCE
  static const String ATTENDANCE_GET_ATTENDANCE_STATISTICS =
      '/attendance/get_attendances_statistics';
  static const String ATTENDANCE_GET_ATTENDANCE =
      '/attendance/get_attendances_for_teachers';
  static const String ATTENDANCE_CREATE = '/attendance/create';
  static const String ATTENDANCE_UPDATE = '/attendance/update';
  static const String ATTENDANCE_DELETE = '/attendance/delete';
}
