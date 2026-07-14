import 'package:ava/core/models/post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_provider.g.dart';

@riverpod
class Posts extends _$Posts {
  static const int defaultLimit = 15;

  @override
  Future<List<PostModel>> build() async {
    return _fetchPosts(limit: defaultLimit);
  }

  Future<List<PostModel>> _fetchPosts({int? limit}) async {
    final queryParameters = <String, dynamic>{};
    if (limit != null) {
      queryParameters['limit'] = limit;
    }
    return [];
    // final response = await ref.watch(apiProvider).get(
    //       '/posts',
    //       queryParameters: queryParameters,
    //     );
    // final responseList = response.data['posts'] as List;
    // return responseList
    //     .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
    //     .toList();
  }

  Future<void> loadMore() async {
    final newLimit = (await future).length + defaultLimit;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _fetchPosts(limit: newLimit),
    );
  }
}
