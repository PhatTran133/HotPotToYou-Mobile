extension DateExtension on DateTime {
  static DateTime addMonths(DateTime dateTime, int monthsToAdd) {
  int yearsToAdd = monthsToAdd ~/ 12; // Số năm cần thêm
  int remainingMonths = monthsToAdd % 12; // Số tháng cần thêm sau khi đã thêm vào năm

  int newYear = dateTime.year + yearsToAdd;
  int newMonth = dateTime.month + remainingMonths;

  // Điều chỉnh nếu số tháng vượt quá 12
  if (newMonth > 12) {
    newYear += 1;
    newMonth -= 12;
  }

  return DateTime(newYear, newMonth, dateTime.day, dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond, dateTime.microsecond);
}
}
