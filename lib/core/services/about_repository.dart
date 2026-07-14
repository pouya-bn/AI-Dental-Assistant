import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/about_model.dart';

class AboutRepository {
  AboutRepository(this.ref);

  final Ref ref;

  Future<AboutModel> getAbout() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/system/information/aboutUs',
          );
      if (response.succeeded) {
        final about = AboutModel.fromJson(
          response.data! as Map<String, dynamic>,
        );
        return about;
      } else {
        logErrors(response.errors);
      }
    } on ApiException catch (e) {
      logger.e("Error getting about: $e");
    }
    throw Exception('Error getting about');
  }
}
