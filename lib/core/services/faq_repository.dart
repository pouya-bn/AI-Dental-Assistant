import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/faq_item_model.dart';

class FaqRepository {
  FaqRepository(this.ref);

  final Ref ref;

  Future<List<FaqItemModel>> getFaqs() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/system/faq',
          );
      if (response.succeeded) {
        final faqs = (response.data! as List)
            .map((e) => FaqItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return faqs;
      } else {
        logErrors(response.errors);
      }
    } on ApiException catch (e) {
      logger.e("Error getting faqs: $e");
    }
    throw Exception('Error getting faqs');
  }

  Future<List<FaqItemModel>> searchFaqs(String query) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/system/faq',
        queryParameters: {'search': query},
      );
      if (response.succeeded) {
        final faqs = (response.data! as List)
            .map((e) => FaqItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return faqs;
      } else {
        logErrors(response.errors);
      }
    } on ApiException catch (e) {
      logger.e("Error searching faqs: $e");
    }
    throw Exception('Error searching faqs');
  }
}
