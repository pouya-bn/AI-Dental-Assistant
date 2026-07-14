import 'package:freezed_annotation/freezed_annotation.dart';

part 'in_person_consult_model.freezed.dart';
part 'in_person_consult_model.g.dart';

@freezed
class InPersonConsultModel with _$InPersonConsultModel {
  const factory InPersonConsultModel({
    required String id,
    required String patientName,
    required String date,
    required String time,
    required String status,
  }) = _InPersonConsultModel;

  const InPersonConsultModel._();

  bool get isAccepted => status == 'تایید شده';

  factory InPersonConsultModel.fromJson(Map<String, dynamic> json) =>
      _$InPersonConsultModelFromJson(json);
}
