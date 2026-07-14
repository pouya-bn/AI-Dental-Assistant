import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
    required String id,
    @Default('نام دندانپزشک') String name,
    @Default('دندانپزشک') String studyField,
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
  }) = _DoctorModel;

  const DoctorModel._();

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

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

@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    required String image,
    int? size,
    int? height,
    int? width,
    String? caption,
    String? alt,
  }) = _MediaModel;

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);
}

@freezed
class LicenseModel with _$LicenseModel {
  const factory LicenseModel({
    required LicenseTypeModel type,
    String? description,
    String? image,
    String? licenseNumber,
  }) = _LicenseModel;

  factory LicenseModel.fromJson(Map<String, dynamic> json) =>
      _$LicenseModelFromJson(json);
}

@freezed
class LicenseTypeModel with _$LicenseTypeModel {
  const factory LicenseTypeModel({
    required int id,
    required String name,
  }) = _LicenseTypeModel;

  factory LicenseTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LicenseTypeModelFromJson(json);
}

@freezed
class ExpertiseModel with _$ExpertiseModel {
  const factory ExpertiseModel({
    required int id,
    required String name,
  }) = _ExpertiseModel;

  factory ExpertiseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpertiseModelFromJson(json);
}

@freezed
class LocatedDoctorModel with _$LocatedDoctorModel {
  const factory LocatedDoctorModel({
    required String id,
    @Default('نام دندانپزشک') String name,
    @Default('دندانپزشک') String studyField,
    @Default('آفلاین') String status,
    String? avatar,
    String? address,
    double? latitude,
    double? longitude,
    String? banner,
  }) = _LocatedDoctorModel;

  const LocatedDoctorModel._();

  factory LocatedDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$LocatedDoctorModelFromJson(json);

  bool get isOnline => status == 'آنلاین';

  factory LocatedDoctorModel.empty() => const LocatedDoctorModel(
        id: '',
        avatar: '',
        name: '',
        address: '',
        studyField: '',
        status: '',
        latitude: 0,
        longitude: 0,
        banner: '',
      );
}
