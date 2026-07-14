import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/file_entry_model.dart';
import 'package:ava/core/models/sickness_model.dart';
import 'package:ava/core/models/user_model.dart';

class UserRepository {
  UserRepository(this.ref);

  final Ref ref;

  Future<UserModel?> getUser() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/account/user',
          );
      if (response.succeeded) {
        final user = UserModel.fromJson(
          response.data! as Map<String, dynamic>,
        );
        return user;
      }
    } on ApiException catch (e) {
      logger.e("Error getting user: $e");
    }
    return null;
  }

  Future<UserModel?> editUser(
    EditUserModel editUser, {
    File? avatar,
  }) async {
    try {
      final response = await ref.read(apiProvider).put(
        '/account/user',
        formData: editUser.toJson(),
        files: [
          FileEntryModel('avatar', avatar),
        ],
      );
      if (response.succeeded) {
        final user = UserModel.fromJson(
          response.data! as Map<String, dynamic>,
        );
        return user;
      }
    } on ApiException catch (e) {
      logger.e("Error editing user: $e");
    }
    return null;
  }

  Future<List<UserSicknessModel>?> getUserSicknesses() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/account/user/sickness',
          );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => UserSicknessModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting user sicknesses: $e");
    }
    return null;
  }

  Future<UserSicknessModel?> createUserSickness(int sicknessId) async {
    try {
      final response = await ref.read(apiProvider).post(
        '/account/user/sickness',
        formData: {'sicknessId': sicknessId},
      );
      if (response.succeeded) {
        final sickness = UserSicknessModel.fromJson(
          response.data! as Map<String, dynamic>,
        );
        AppToast.showSuccess(
          title: response.message ?? 'سابقه بیماری با موفقیت اضافه شد',
        );
        return sickness;
      } else {
        if (response.errors?.isNotEmpty ?? false) {
          logErrors(response.errors);
          AppToast.showError(
            title: 'خطا در افزودن سابقه بیماری',
            description: response.errors?.first.message,
          );
        } else {
          logger.e('Unknown error while creating user sickness');
          AppToast.showError(
            title: 'خطا در افزودن سابقه بیماری',
            description: 'لطفا دوباره تلاش کنید',
          );
        }
      }
    } on ApiException catch (e) {
      logger.e("Error creating user sickness: $e");
    }
    return null;
  }

  Future<bool> deleteUserSickness(int id) async {
    try {
      final response = await ref.read(apiProvider).delete(
        '/account/user/sickness',
        queryParameters: {'id': id},
      );
      if (response.succeeded) {
        AppToast.showSuccess(
          title: response.message ?? 'سابقه بیماری با موفقیت حذف شد',
        );
        return true;
      } else {
        if (response.errors?.isNotEmpty ?? false) {
          logErrors(response.errors);
          AppToast.showError(
            title: 'خطا در حذف سابقه بیماری',
            description: response.errors?.first.message,
          );
        } else {
          logger.e('Unknown error while deleting user sickness');
          AppToast.showError(
            title: 'خطا در حذف سابقه بیماری',
            description: 'لطفا دوباره تلاش کنید',
          );
        }
      }
    } on ApiException catch (e) {
      logger.e("Error deleting user sickness: $e");
    }
    return false;
  }
}
