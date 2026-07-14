import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import 'doctor_model.dart';

part 'clinic_model.freezed.dart';
part 'clinic_model.g.dart';

@freezed
class ClinicModel with _$ClinicModel {
  const factory ClinicModel({
    required String id,
    @Default('نام کلینیک') String name,
    @Default('کلینیک دندانپزشکی') String studyField,
    @Default('آفلاین') String status,
    @Default(0) int commentCount,
    @Default(0) int rate,
    @Default([]) List<MediaModel> gallery,
    String? avatar,
    String? phoneNumber,
    String? openTime,
    String? zipCode,
    String? medicalLicenseNumber,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    @Default(false) bool hasPhoneConsultancy,
    int? phoneConsultancyPrice,
    @Default(false) bool hasChatConsultancy,
    int? chatConsultancyPrice,
    @Default([]) List<LicenseModel> licenses,
    @Default([]) List<ExpertiseModel> expertises,
  }) = _ClinicModel;

  const ClinicModel._();

  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);

  LatLng? get location => (latitude != null && longitude != null)
      ? LatLng(latitude!, longitude!)
      : null;

  bool get isOnline => status == 'آنلاین';

  bool get hasPhoneNumber => phoneNumber?.isNotEmpty ?? false;

  bool get hasOpenTime => openTime?.isNotEmpty ?? false;

  bool get hasZipCode => zipCode?.isNotEmpty ?? false;

  bool get hasContactInfo => hasPhoneNumber || hasOpenTime || hasZipCode;

  bool get hasDescription => description?.isNotEmpty ?? false;

  bool get hasMedicalLicenseNumber => medicalLicenseNumber?.isNotEmpty ?? false;

  bool get hasAbout => hasDescription || hasMedicalLicenseNumber;

  bool get hasAddress =>
      (address?.isNotEmpty ?? false) || (latitude != null && longitude != null);

  bool get hasLicenses => licenses.isNotEmpty;

  bool get hasExpertises => expertises.isNotEmpty;
}
