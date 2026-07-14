import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'education_model.freezed.dart';
part 'education_model.g.dart';

@freezed
@HiveType(typeId: 2)
class EducationModel with _$EducationModel {
  const factory EducationModel({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
  }) = _EducationModel;

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);
}
