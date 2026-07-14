import 'package:ava/core/models/clinic_model.dart';
import 'package:ava/core/services/clinic_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clinic_provider.g.dart';

@riverpod
ClinicRepository clinicRepository(ClinicRepositoryRef ref) {
  return ClinicRepository(ref);
}

@riverpod
class Clinic extends _$Clinic {
  late final ClinicRepository _clinicRepo;

  @override
  Future<ClinicModel> build(String clinicId) async {
    _clinicRepo = ref.watch(clinicRepositoryProvider);
    return await getClinic(clinicId: clinicId);
  }

  Future<ClinicModel> getClinic({
    required String clinicId,
  }) async {
    return await _clinicRepo.getClinic(clinicId);
  }
}
