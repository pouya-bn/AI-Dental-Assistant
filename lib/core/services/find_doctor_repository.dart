import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/doctor_model.dart';
import 'package:latlong2/latlong.dart';

class FindDoctorRepository {
  FindDoctorRepository(this.ref);

  final Ref ref;

  Future<List<LocatedDoctorModel>?> getNearbyDoctors(LatLng latLng) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/service/findDoctor',
        queryParameters: {
          'latitude': latLng.latitude,
          'longitude': latLng.longitude,
        },
      );
      if (response.succeeded) {
        final doctors = (response.data! as List)
            .map((e) => LocatedDoctorModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return doctors;
      }
    } on ApiException catch (e) {
      logger.e("Error getting doctors: $e");
    }
    return null;
  }

  Future<List<LocatedDoctorModel>?> findDoctors(
    LatLng latLng,
    String query,
  ) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/service/findDoctor',
        queryParameters: {
          'latitude': latLng.latitude,
          'longitude': latLng.longitude,
        },
      );
      if (response.succeeded) {
        final doctors = (response.data! as List)
            .map((e) => LocatedDoctorModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return doctors;
      }
    } on ApiException catch (e) {
      logger.e("Error getting doctors: $e");
    }
    return null;
  }
}
