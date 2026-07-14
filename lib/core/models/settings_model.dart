import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required bool safeCall,
    required bool rssEmail,
    required bool treatmentEmail,
    required String language,
    required bool appointmentNotice,
    required bool newsNotice,
    required bool calendarNotice,
    required bool useWheelChair,
    required bool isDeaf,
    required bool isBlind,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
