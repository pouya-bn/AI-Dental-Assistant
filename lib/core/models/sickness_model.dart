import 'package:freezed_annotation/freezed_annotation.dart';

part 'sickness_model.freezed.dart';
part 'sickness_model.g.dart';

@freezed
class SicknessModel with _$SicknessModel {
  const factory SicknessModel({
    required int id,
    required String name,
    required String category,
  }) = _SicknessModel;

  factory SicknessModel.fromJson(Map<String, dynamic> json) =>
      _$SicknessModelFromJson(json);
}

@freezed
class UserSicknessModel with _$UserSicknessModel {
  const factory UserSicknessModel({
    required int id,
    required int sicknessId,
    String? sicknessName,
    String? sicknessCategoryName,
  }) = _UserSicknessModel;

  factory UserSicknessModel.fromJson(Map<String, dynamic> json) =>
      _$UserSicknessModelFromJson(json);
}
