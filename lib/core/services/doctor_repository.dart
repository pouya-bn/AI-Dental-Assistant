import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/doctor_model.dart';

class DoctorRepository {
  DoctorRepository(this.ref);

  final Ref ref;

  Future<DoctorModel> getDoctor(String doctorId) async {
    try {
      final response = await ref.read(apiProvider).get(
            '/service/findDoctor/$doctorId',
          );
      if (response.succeeded) {
        final doctor = DoctorModel.fromJson(
          response.data! as Map<String, dynamic>,
        );
        return doctor;
      }
    } on ApiException catch (e) {
      logger.e("Error getting doctor: $e");
    }
    throw Exception('Error getting doctor');
  }
}
