import 'package:ava/core/models/doctor_model.dart';
import 'package:ava/core/services/map_repository.dart';
import 'package:ava/core/utils/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

part 'map_provider.g.dart';

@riverpod
MapRepository mapRepository(MapRepositoryRef ref) {
  return MapRepository(ref);
}

@riverpod
class SelfLocation extends _$SelfLocation {
  @override
  Future<LatLng> build() async {
    state = const AsyncLoading();
    final location = await getSelfLocation();
    return LatLng(location.latitude, location.longitude);
  }
}

@riverpod
class Map extends _$Map {
  final sheetController = SheetController();
  static final _empty = LocatedDoctorModel.empty();
  LatLng? center;

  @override
  LocatedDoctorModel build() => _empty;

  bool get isDoctorShown => state.id.isNotEmpty;

  void showDoctor(LocatedDoctorModel doctor) {
    sheetController.hide();
    state = doctor;
  }

  void hideDoctor({LatLng? center}) {
    sheetController.show();
    state = _empty;
    if (center != null) {
      this.center = center;
    }
  }
}

@riverpod
class LocatedDoctors extends _$LocatedDoctors {
  @override
  Future<List<LocatedDoctorModel>> build() async {
    final center = ref.watch(mapProvider.notifier).center;
    if (center != null) {
      state = const AsyncLoading();
      final doctors =
          await ref.read(mapRepositoryProvider).getNearbyDoctors(center);
      return doctors ?? [];
    }
    final selfLocation = ref.watch(selfLocationProvider);
    return await selfLocation.maybeWhen(
      data: (latLng) async {
        state = const AsyncLoading();
        final doctors =
            await ref.read(mapRepositoryProvider).getNearbyDoctors(latLng);
        return doctors ?? [];
      },
      orElse: () => [],
    );
  }
}
