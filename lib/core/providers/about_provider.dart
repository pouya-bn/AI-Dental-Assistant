import 'package:ava/core/models/about_model.dart';
import 'package:ava/core/services/about_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'about_provider.g.dart';

@riverpod
AboutRepository aboutRepository(AboutRepositoryRef ref) {
  return AboutRepository(ref);
}

@riverpod
class About extends _$About {
  @override
  Future<AboutModel> build() async {
    return await ref.watch(aboutRepositoryProvider).getAbout();
  }
}
