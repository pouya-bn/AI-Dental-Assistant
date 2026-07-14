import 'package:ava/common/values/imports.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

String formatMinuteSecond(int seconds) {
  final min = (seconds / 60).floor();
  final sec = seconds % 60;
  return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
}

String? getStorageUrl(String? url) {
  if (url != null && url.trim().isNotEmpty) {
    final fullUrl =
        url.startsWith('http') ? url : '${AppStrings.apiBaseUrl}/$url';
    if (fullUrl.trim().isNotEmpty) {
      return fullUrl;
    }
  }
  return null;
}

String formatJalali(Jalali jalali) {
  return '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';
}

String formatGregorian(Gregorian gregorian) {
  return '${gregorian.year}-${gregorian.month.toString().padLeft(2, '0')}-${gregorian.day.toString().padLeft(2, '0')}';
}

String formatCount(int count) {
  if (count < 1000) {
    return count.toString();
  } else {
    double convertedCount = count / 1000.0;
    String unit = 'K';
    if (convertedCount >= 1000) {
      convertedCount /= 1000.0;
      unit = 'M';
    }
    return '${convertedCount.toStringAsFixed(1)}$unit';
  }
}

String formatCreatedOn(DateTime createdOn) {
  final dayFormat = DateFormat.EEEE('fa_IR');
  final monthFormat = DateFormat.MMMM('fa_IR');
  final timeFormat = DateFormat('HH:mm');

  final dayOfWeek = dayFormat.format(createdOn);
  final dayOfMonth = DateFormat('d').format(createdOn);
  final monthName = monthFormat.format(createdOn);
  final year = DateFormat('y').format(createdOn);

  final time = timeFormat.format(createdOn);

  return '$dayOfWeek $dayOfMonth $monthName $year | ساعت $time';
}
