import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/forum_model.dart';

class ForumRepository {
  ForumRepository(this.ref);

  final Ref ref;

  Future<List<ForumHallsModel>> getForumHallsTop() async {
    try {
      final response = await ref.read(apiProvider).get(
            '/forum/top',
          );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => ForumHallsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting ForumHallsTop: $e");
      rethrow;
    }
    return [];
  }

  Future<List<ForumHallsModel>> getForumHalls({
    String? search,
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/forum',
        queryParameters: {
          'search': search,
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => ForumHallsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting ForumHalls: $e");
      rethrow;
    }
    return [];
  }

  Future<ForumHallModel> getForumHall(String id) async {
    try {
      final response = await ref.read(apiProvider).get(
            '/forum/$id',
          );
      if (response.succeeded) {
        final about = ForumHallModel.fromJson(
          response.data! as Map<String, dynamic>,
        );
        return about;
      } else {
        logErrors(response.errors);
      }
    } on ApiException catch (e) {
      logger.e("Error getting ForumHall: $e");
    }
    throw Exception('Error getting ForumHall');
  }

  Future<List<ForumTileModel>> getForumHallTiles({
    int? type,
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final response = await ref.read(apiProvider).get(
        '/forum',
        queryParameters: {
          'type': type,
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      if (response.succeeded) {
        return (response.data! as List)
            .map((e) => ForumTileModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on ApiException catch (e) {
      logger.e("Error getting ForumHallTiles: $e");
      rethrow;
    }
    return [];
  }
}
