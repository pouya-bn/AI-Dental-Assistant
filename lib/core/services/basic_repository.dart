import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/address_model.dart';
import 'package:ava/core/models/country_model.dart';
import 'package:ava/core/models/day_model.dart';
import 'package:ava/core/models/education_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/models/sickness_model.dart';

class BasicRepository {
  BasicRepository(this.ref);

  final Ref ref;

  Future<List<GenderModel>> getGenders() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/basic/static/gender',
          );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => GenderModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting genders: $e");
    }
    return [];
  }

  Future<List<EducationModel>> getEducations() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/basic/static/education',
          );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => EducationModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting educations: $e");
    }
    return [];
  }

  Future<List<CountryModel>> getCountries({
    String? search,
    int? id,
    bool? isDesc,
  }) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/basic/country',
        queryParameters: {
          'search': search,
          'id': id,
          'isDesc': isDesc,
        },
      );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting countries: $e");
    }
    return [];
  }

  Future<List<ProvinceModel>> getProvinces({
    required int countryId,
    String? search,
    int? id,
    bool? isDesc,
  }) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/basic/province',
        queryParameters: {
          'countryId': countryId,
          'search': search,
          'id': id,
          'isDesc': isDesc,
        },
      );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => ProvinceModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting provinces: $e");
    }
    return [];
  }

  Future<List<CityModel>> getCities({
    required int provinceId,
    String? search,
    int? id,
    bool? isDesc,
  }) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/basic/city',
        queryParameters: {
          'provinceId': provinceId,
          'search': search,
          'id': id,
          'isDesc': isDesc,
        },
      );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting cities: $e");
    }
    return [];
  }

  Future<List<DayModel>> getDays() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/basic/static/weekday',
          );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => DayModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting days: $e");
    }
    return [];
  }

  Future<List<SicknessModel>> getSicknesses({String? search}) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/basic/sickness',
        queryParameters: {
          'search': search,
        },
      );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => SicknessModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting sicknesses: $e");
    }
    return [];
  }
}
