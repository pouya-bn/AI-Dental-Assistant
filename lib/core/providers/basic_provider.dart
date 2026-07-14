import 'package:ava/core/models/address_model.dart';
import 'package:ava/core/models/day_model.dart';
import 'package:ava/core/models/education_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/models/sickness_model.dart';
import 'package:ava/core/providers/user_provider.dart';
import 'package:ava/core/services/basic_repository.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_provider.g.dart';

@Riverpod(keepAlive: true)
BasicRepository basicRepository(BasicRepositoryRef ref) {
  return BasicRepository(ref);
}

@Riverpod(keepAlive: true)
class Basic extends _$Basic {
  BasicRepository get _repo => ref.watch(basicRepositoryProvider);

  List<GenderModel> genders = [];
  List<EducationModel> educations = [];
  List<DayModel> days = [];

  GenderModel? gender;
  EducationModel? education;
  AddressModel address = AddressModel(
    address: self.address,
    number: self.number,
    unit: self.unit,
    province: null,
    city: null,
  );

  @override
  Future<void> build() async {
    genders = await _repo.getGenders();
    gender = _getGender(self.gender?.id);
    educations = await _repo.getEducations();
    education = _getEducation(self.education?.id);
    address = _getAddress();
    days = await _repo.getDays();
  }

  GenderModel? _getGender(int? id) {
    if (id == null) return self.gender;
    return genders.firstWhereOrNull((element) => element.id == id);
  }

  EducationModel? _getEducation(int? id) {
    if (id == null) return self.education;
    return educations.firstWhereOrNull((element) => element.id == id);
  }

  AddressModel _getAddress() {
    if (self.provinceId != null && self.provinceName != null) {
      address = address.copyWith(
        province: ProvinceModel(
          id: self.provinceId!,
          name: self.provinceName!,
        ),
      );
    }
    if (self.cityId != null && self.cityName != null) {
      address = address.copyWith(
        city: CityModel(
          id: self.cityId!,
          name: self.cityName!,
        ),
      );
    }
    return address;
  }

  DayModel? getDay(int id) {
    return days.firstWhereOrNull((element) => element.id == id);
  }
}

@riverpod
class Province extends _$Province {
  BasicRepository get _repo => ref.watch(basicRepositoryProvider);

  @override
  Future<List<ProvinceModel>> build({required int countryId}) async {
    return await _repo.getProvinces(countryId: countryId);
  }

  Future<void> getAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getProvinces(countryId: countryId);
    });
  }

  Future<void> search(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getProvinces(
        countryId: countryId,
        search: query,
      );
    });
  }
}

@riverpod
class City extends _$City {
  BasicRepository get _repo => ref.watch(basicRepositoryProvider);

  @override
  Future<List<CityModel>> build({required int provinceId}) async {
    return await _repo.getCities(provinceId: provinceId);
  }

  Future<void> getAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getCities(provinceId: provinceId);
    });
  }

  Future<void> search(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getCities(
        provinceId: provinceId,
        search: query,
      );
    });
  }
}

@riverpod
class Sickness extends _$Sickness {
  BasicRepository get _repo => ref.watch(basicRepositoryProvider);

  @override
  Future<List<SicknessModel>> build() async {
    return await _repo.getSicknesses();
  }

  Future<void> getAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getSicknesses();
    });
  }

  Future<void> search(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getSicknesses(search: query);
    });
  }
}
