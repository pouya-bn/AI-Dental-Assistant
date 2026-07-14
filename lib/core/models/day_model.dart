import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_model.freezed.dart';
part 'day_model.g.dart';

@freezed
class DayModel with _$DayModel {
  const factory DayModel({
    required int id,
    required String name,
  }) = _DayModel;

  factory DayModel.fromJson(Map<String, dynamic> json) =>
      _$DayModelFromJson(json);
}
