import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/doctor_model.dart';
import 'package:ava/core/providers/map_provider.dart';
import 'package:ava/core/services/find_doctor_repository.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'find_doctor_provider.g.dart';

@riverpod
FindDoctorRepository findDoctorRepository(FindDoctorRepositoryRef ref) {
  return FindDoctorRepository(ref);
}

@riverpod
class FindDoctor extends _$FindDoctor {
  FindDoctorRepository get _repo => ref.watch(findDoctorRepositoryProvider);

  @override
  Future<List<LocatedDoctorModel>> build({LatLng? latLng}) async {
    if (latLng != null) {
      state = const AsyncLoading();
      final doctors = await _repo.getNearbyDoctors(latLng);
      return doctors ?? [];
    }
    final selfLocation = ref.watch(selfLocationProvider);
    return await selfLocation.maybeWhen(
      data: (selfLatLng) async {
        state = const AsyncLoading();
        final doctors = await _repo.getNearbyDoctors(selfLatLng);
        return doctors ?? [];
      },
      orElse: () => [],
    );
  }
}

@riverpod
class FindDoctorResult extends _$FindDoctorResult {
  FindDoctorRepository get _repo => ref.watch(findDoctorRepositoryProvider);

  @override
  Future<List<LocatedDoctorModel>> build() async => [];

  Future<void> find({LatLng? latLng, String? query}) async {
    if (query == null) {
      state = const AsyncData([]);
      return;
    }
    if (latLng != null) {
      state = const AsyncLoading();
      final doctors = await _repo.findDoctors(latLng, query);
      state = AsyncData(doctors ?? []);
      return;
    }
    final selfLocation = ref.watch(selfLocationProvider);
    return await selfLocation.maybeWhen(
      data: (selfLatLng) async {
        state = const AsyncLoading();
        final doctors = await _repo.findDoctors(selfLatLng, query);
        state = AsyncData(doctors ?? []);
        return;
      },
      orElse: () => [],
    );
  }
}

@Riverpod(keepAlive: true)
class FindDoctorFilter extends _$FindDoctorFilter {
  @override
  FindDoctorFilterState build() {
    return const FindDoctorFilterState();
  }

  void setType(FindDoctorType value) {
    state = state.copyWith(type: () => value);
  }

  void setRate(FindDoctorRate value) {
    state = state.copyWith(rate: () => value);
  }

  void toggleSpecialty(FindDoctorSpecialty value) {
    state = state.copyWith(
      specialties: () {
        var specialties = state.specialties.toSet();
        if (specialties.contains(value)) {
          specialties.remove(value);
        } else {
          specialties.add(value);
        }
        logger.d(specialties);
        return specialties;
      },
    );
  }

  void clear() {
    state = const FindDoctorFilterState();
  }
}

class FindDoctorFilterState {
  final FindDoctorType type;
  final FindDoctorRate rate;
  final Set<FindDoctorSpecialty> specialties;

  const FindDoctorFilterState({
    this.type = FindDoctorType.all,
    this.rate = FindDoctorRate.all,
    this.specialties = const {FindDoctorSpecialty.all},
  });

  FindDoctorFilterState copyWith({
    FindDoctorType? Function()? type,
    FindDoctorRate? Function()? rate,
    Set<FindDoctorSpecialty>? Function()? specialties,
  }) {
    return FindDoctorFilterState(
      type: type?.call() ?? this.type,
      rate: rate?.call() ?? this.rate,
      specialties: specialties?.call() ?? this.specialties,
    );
  }
}
