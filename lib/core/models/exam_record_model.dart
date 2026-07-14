import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_record_model.freezed.dart';
part 'exam_record_model.g.dart';

@freezed
class ExamRecordModel with _$ExamRecordModel {
  const factory ExamRecordModel({
    required String id,
    required String doctorName,
    required String date,
    required String time,
    required String insuranceCode,
    required String medicine,
    required String medicineUsage,
  }) = _ExamRecordModel;

  factory ExamRecordModel.fromJson(Map<String, dynamic> json) =>
      _$ExamRecordModelFromJson(json);
}
