import 'package:ava/core/models/education_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/models/settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserResponseModel with _$UserResponseModel {
  const factory UserResponseModel({
    required String token,
    required UserModel user,
  }) = _UserResponseModel;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);
}

@freezed
@HiveType(typeId: 0)
class UserModel with _$UserModel {
  const factory UserModel({
    @HiveField(0) required String id,
    @HiveField(1) required String username,
    @HiveField(2) String? firstName,
    @HiveField(3) String? lastName,
    @HiveField(4) GenderModel? gender,
    @HiveField(5) EducationModel? education,
    @HiveField(6) String? studyField,
    @HiveField(7) bool? isActive,
    @HiveField(8) bool? isDentist,
    @HiveField(9) bool? isClinic,
    @HiveField(10) String? avatarUrl,
    @HiveField(11) String? email,
    @HiveField(12) String? birthdate,
    @HiveField(13) int? nationalCode,
    @HiveField(14) String? dateJoined,
    @HiveField(15) int? countryId,
    @HiveField(16) String? countryName,
    @HiveField(17) int? provinceId,
    @HiveField(18) String? provinceName,
    @HiveField(19) int? cityId,
    @HiveField(20) String? cityName,
    @HiveField(21) String? address,
    @HiveField(22) int? number,
    @HiveField(23) int? unit,
    @HiveField(24) String? zipCode,
    @HiveField(25) SettingsModel? setting,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.empty() => const UserModel(
        id: '',
        username: '',
        firstName: 'نام',
        lastName: 'نام خانوادگی',
      );

  String get fullName => '$firstName $lastName';
}

@freezed
class EditUserModel with _$EditUserModel {
  const factory EditUserModel({
    String? firstName,
    String? lastName,
    int? gender,
    int? education,
    String? birthdate,
    String? email,
    int? nationalCode,
    String? studyField,
    int? countryId,
    int? provinceId,
    int? cityId,
    String? address,
    int? number,
    int? unit,
    String? zipCode,
  }) = _EditUserModel;

  factory EditUserModel.fromJson(Map<String, dynamic> json) =>
      _$EditUserModelFromJson(json);
}
