import 'package:ava/core/utils/format.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

part 'date_model.freezed.dart';

@freezed
class DateModel with _$DateModel {
  const factory DateModel({
    required Jalali jalali,
  }) = _DateModel;

  const DateModel._();

  factory DateModel.fromJalali(Jalali jalali) => DateModel(jalali: jalali);

  Gregorian get gregorian => jalali.toGregorian();

  String get jalaliString => formatJalali(jalali);

  String get gregorianString => formatGregorian(gregorian);

  @override
  String toString() {
    return """DateModel(
  jalali: $jalali,
  gregorian: $gregorian,
  jalaliString: $jalaliString,
  gregorianString: $gregorianString,
)""";
  }
}
