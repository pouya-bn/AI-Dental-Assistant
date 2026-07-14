import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/settings_model.dart';

class SettingsRepository {
  SettingsRepository(this.ref);

  final Ref ref;

  Future<SettingsModel> getSettings() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/account/user/setting',
          );
      if (response.succeeded) {
        return SettingsModel.fromJson(response.data! as Map<String, dynamic>);
      } else {
        logErrors(response.errors);
      }
    } on ApiException catch (e) {
      logger.e("Error getting settings: $e");
    }
    throw Exception('Error getting settings');
  }

  Future<(bool, String?)> confirmSettings(SettingsModel settings) async {
    try {
      final response = await ref.read(apiProvider).put(
            '/account/user/setting',
            formData: settings.toJson(),
          );
      if (!response.succeeded) {
        logErrors(response.errors);
      }
      return (response.succeeded, response.message);
    } on ApiException catch (e) {
      logger.e("Error searching settings: $e");
    }
    throw Exception('Error searching settings');
  }
}
