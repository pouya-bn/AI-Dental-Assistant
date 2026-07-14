import 'dart:io';

import 'package:ava/core/models/consult_model.dart';
import 'package:ava/core/models/doctor_model.dart';
import 'package:ava/core/services/doctor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'doctor_provider.g.dart';

@riverpod
DoctorRepository doctorRepository(DoctorRepositoryRef ref) {
  return DoctorRepository(ref);
}

@riverpod
class Doctor extends _$Doctor {
  late final DoctorRepository _doctorRepo;
  ConsultModel? consultPhone;
  ConsultModel? consultText;

  @override
  Future<DoctorModel> build(String doctorId) async {
    _doctorRepo = ref.watch(doctorRepositoryProvider);
    return await getDoctor(doctorId: doctorId);
  }

  void reserveConsult() {}

  void setConsultPhone({
    DateTime? time,
    String? brief,
    File? document,
  }) {
    consultPhone = consultPhone?.copyWith(
      time: time,
      brief: brief,
      document: document,
    );
  }

  void setConsultText({
    DateTime? time,
    String? brief,
    File? document,
  }) {
    consultText = consultText?.copyWith(
      time: time,
      brief: brief,
      document: document,
    );
  }

  Future<DoctorModel> getDoctor({
    required String doctorId,
  }) async {
    return await _doctorRepo.getDoctor(doctorId);
  }
}
