import 'package:ava/core/models/faq_item_model.dart';
import 'package:ava/core/services/faq_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'faq_provider.g.dart';

@riverpod
FaqRepository faqRepository(FaqRepositoryRef ref) {
  return FaqRepository(ref);
}

@riverpod
class Faq extends _$Faq {
  FaqRepository get _faqRepo => ref.watch(faqRepositoryProvider);

  @override
  Future<List<FaqItemModel>> build() async {
    return await _faqRepo.getFaqs();
  }

  Future<void> getAllFaqs() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return _faqRepo.getFaqs();
    });
  }

  Future<void> searchFaqs(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return _faqRepo.searchFaqs(query);
    });
  }
}
