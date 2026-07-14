import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'gender_model.freezed.dart';
part 'gender_model.g.dart';

@freezed
@HiveType(typeId: 1)
class GenderModel with _$GenderModel {
  const factory GenderModel({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
  }) = _GenderModel;

  factory GenderModel.fromJson(Map<String, dynamic> json) =>
      _$GenderModelFromJson(json);
}
