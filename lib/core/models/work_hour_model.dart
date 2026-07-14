import 'package:ava/core/models/day_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_hour_model.freezed.dart';
part 'work_hour_model.g.dart';

@freezed
class WorkHourModel with _$WorkHourModel {
  const factory WorkHourModel({
    DayModel? day,
    String? startTime,
    String? endTime,
  }) = _WorkHourModel;

  const WorkHourModel._();

  String? get timeRange =>
      startTime != null && endTime != null ? '$startTime - $endTime' : null;

  factory WorkHourModel.fromJson(Map<String, dynamic> json) =>
      _$WorkHourModelFromJson(json);
}
