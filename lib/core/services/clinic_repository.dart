import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/clinic_model.dart';

class ClinicRepository {
  ClinicRepository(this.ref);

  final Ref ref;

  Future<ClinicModel> getClinic(String clinicId) async {
    try {
      final response = await ref.read(apiProvider).get(
            '/service/findDoctor/$clinicId',
          );
      if (response.succeeded) {
        final clinic = ClinicModel.fromJson(
          response.data! as Map<String, dynamic>,
        );
        return clinic;
      }
    } on ApiException catch (e) {
      logger.e("Error getting clinic: $e");
    }
    throw Exception('Error getting clinic');
  }
}
