import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/date_model.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

Future<DateModel?> showCustomDatePicker(
  BuildContext context, {
  DateModel? initialDate,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  final jalali = await showPersianDatePicker(
    context: context,
    errorFormatText: 'تاریخ اشتباه است',
    errorInvalidText: 'تاریخ اشتباه است',
    initialDate: initialDate?.jalali ??
        (initialDate?.jalaliString != null &&
                initialDate?.gregorianString != null
            ? Jalali.fromDateTime(DateTime.parse(
                initialDate!.gregorianString,
              ))
            : Jalali.now()),
    firstDate: Jalali(1300, 8),
    lastDate: Jalali.now(),
  );
  if (jalali != null) {
    final result = DateModel(jalali: jalali);
    logger(result.toString());
    return result;
  }
  return null;
}
