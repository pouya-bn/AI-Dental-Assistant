import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/settings_model.dart';
import 'package:ava/core/models/user_model.dart';
import 'package:ava/core/providers/user_provider.dart';
import 'package:ava/core/services/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  return SettingsRepository(ref);
}

@riverpod
class Settings extends _$Settings {
  SettingsRepository get _repo => ref.watch(settingsRepositoryProvider);
  SettingsModel? initialSettings;

  @override
  Future<SettingsModel> build() async {
    final settings = await _repo.getSettings();
    initialSettings = settings;
    return settings;
  }

  void updateSettings(SettingsModel settings) {
    state = AsyncValue.data(settings);
  }

  Future<void> confirmSettings() async {
    if (state.hasValue && !state.isLoading) {
      final updatedSettings = state.value!;
      final result = await _repo.confirmSettings(updatedSettings);
      if (result.$1) {
        final updatedUser = self.copyWith(
          setting: updatedSettings,
        );
        self = updatedUser;
        Hive.box<UserModel>(AppStrings.userBox).put('current', updatedUser);
        AppToast.showSuccess(
          title: result.$2 ?? 'تنظیمات با موفقیت بروز شد',
        );
      } else {
        AppToast.showError(
          title: result.$2 ?? 'خطا در بروزرسانی تنظیمات',
        );
      }
    } else {
      AppToast.showError(
        title: 'خطا در بروزرسانی تنظیمات',
      );
    }
  }
}
