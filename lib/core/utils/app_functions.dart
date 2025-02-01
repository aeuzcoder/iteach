import 'package:intl/intl.dart';

class AppFunctions {
  static String formattingPrice(int? price) {
    return NumberFormat.decimalPattern('ru').format(price);
  }

  static String imageUrl(String url) {
    return 'https://mycaff.uz/images/$url';
  }

  static String formatDate(String date) {
    List<String> parts = date.split('-');
    if (parts.length != 3) {
      return date; // Если формат неверный, вернуть как есть
    }
    return '${parts[2]}.${parts[1]}.${parts[0]}';
  }
}
