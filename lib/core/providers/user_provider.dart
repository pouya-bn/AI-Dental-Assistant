import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/address_model.dart';
import 'package:ava/core/models/education_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/models/sickness_model.dart';
import 'package:ava/core/models/user_model.dart';
import 'package:ava/core/providers/basic_provider.dart';
import 'package:ava/core/services/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

UserModel self =
    Hive.box<UserModel>(AppStrings.userBox).get('current') ?? UserModel.empty();

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(ref);
}

@riverpod
class User extends _$User {
  UserRepository get _repo => ref.watch(userRepositoryProvider);

  GenderModel? gender;
  EducationModel? education;
  AddressModel? address;
  List<UserSicknessModel> sicknesses = [];

  @override
  Future<UserModel?> build() async {
    await ref.watch(basicProvider.future);
    final basicNotifier = ref.watch(basicProvider.notifier);
    gender = basicNotifier.gender;
    education = basicNotifier.education;
    address = basicNotifier.address;
    sicknesses = await getUserSicknesses();
    return await getUser();
  }

  void set(UserModel user) {
    self = user;
    Hive.box<UserModel>(AppStrings.userBox).put('current', user);
    state = AsyncData(user);
  }

  Future<UserModel?> getUser() async {
    final user = await _repo.getUser();
    if (user != null) {
      return user;
    }
    return null;
  }

  Future<bool> editUser({
    required EditUserModel editUser,
    File? avatar,
  }) async {
    final editedUser = await _repo.editUser(
      editUser,
      avatar: avatar,
    );
    if (editedUser != null) {
      set(editedUser);
      return true;
    }
    return false;
  }

  Future<List<UserSicknessModel>> getUserSicknesses() async {
    final sicknesses = await _repo.getUserSicknesses();
    if (sicknesses != null) {
      return sicknesses;
    }
    return [];
  }

  Future<UserSicknessModel?> createUserSickness({
    required int sicknessId,
  }) async {
    return await _repo.createUserSickness(sicknessId);
  }

  Future<bool> deleteUserSickness({required int id}) async {
    return await _repo.deleteUserSickness(id);
  }

  void updateAddress(AddressModel? address) {
    this.address = address;
  }
}
