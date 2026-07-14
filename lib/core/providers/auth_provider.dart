import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/user_model.dart';
import 'package:ava/core/providers/navbar_provider.dart';
import 'package:ava/core/providers/splash_provider.dart';
import 'package:ava/core/providers/storage_provider.dart';
import 'package:ava/core/services/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:ava/common/values/enums.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  final _introBox = Hive.box<bool>(AppStrings.introBox);
  final _userBox = Hive.box<UserModel>(AppStrings.userBox);

  SecureStorage get _storage => ref.watch(secureStorageProvider);

  @override
  Future<AuthStatus> build() async {
    await ref.watch(splashProvider.future);
    final introSeen = _introBox.get(
          AppStrings.appIntroKey,
          defaultValue: false,
        ) ??
        false;
    if (!introSeen) {
      return AuthStatus.intro;
    }
    final token = _storage.get(AppStrings.tokenKey);
    if (token != null) {
      return AuthStatus.authenticated;
    }
    return AuthStatus.unauthenticated;
  }

  void set(AuthStatus status) {
    state = AsyncData(status);
  }

  Future<void> login({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await ref.read(apiProvider).post(
        '/auth/login',
        formData: {
          'username': phone,
          'otp': otp,
        },
      );

      if (response.succeeded) {
        final userResponse = UserResponseModel.fromJson(
          response.data! as Map<String, dynamic>,
        );
        final token = userResponse.token;
        final user = userResponse.user;

        logger(user.toJson());

        _userBox.put('current', user);
        await _storage.write(AppStrings.tokenKey, token);

        ref
          ..invalidateSelf()
          ..invalidate(apiProvider);
      } else {
        if (response.errors?.isNotEmpty ?? false) {
          logErrors(response.errors);
          AppToast.showError(
            title: 'خطا در ورود',
            description: response.errors?.first.message,
          );
        } else {
          logger.e('Unknown error while logging in');
          AppToast.showError(
            title: 'خطا در ورود',
            description: 'لطفا دوباره تلاش کنید',
          );
        }
      }
    } on ApiException catch (e) {
      logger.e(e);
      AppToast.showError(
        title: 'خطا در ورود',
        description: 'لطفا دوباره تلاش کنید',
      );
    }
  }

  Future<bool> sendOtp({required String phone}) async {
    try {
      final response = await ref.read(apiProvider).post(
        '/auth/sendOtp',
        formData: {'username': phone},
      );
      if (response.succeeded) {
        logger('OTP sent to $phone');
        return true;
      } else {
        if (response.errors?.isNotEmpty ?? false) {
          logErrors(response.errors);
          AppToast.showError(
            title: 'خطا در ارسال کد',
            description: response.errors?.first.message,
          );
        } else {
          logger.e('Unknown error while sending OTP');
          AppToast.showError(
            title: 'خطا در ارسال کد',
            description: 'لطفا دوباره تلاش کنید',
          );
        }
      }
    } on ApiException catch (e) {
      logger.e(e);
      AppToast.showError(
        title: 'خطا در ارسال کد',
        description: 'لطفا دوباره تلاش کنید',
      );
    }
    return false;
  }

  void signOut() {
    _userBox.delete('current');
    _storage.delete(AppStrings.tokenKey);
    ref.read(navbarProvider.notifier).change(0);
    ref
      ..invalidateSelf()
      ..invalidate(apiProvider);
  }
}
