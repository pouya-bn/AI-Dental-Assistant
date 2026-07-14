import 'package:ava/core/models/forum_model.dart';
import 'package:ava/core/models/paginated_model.dart';
import 'package:ava/core/services/forum_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forum_provider.g.dart';

@Riverpod(keepAlive: true)
ForumRepository forumRepository(ForumRepositoryRef ref) {
  return ForumRepository(ref);
}

@Riverpod(keepAlive: true)
class TopForumHalls extends _$TopForumHalls {
  ForumRepository get _repo => ref.watch(forumRepositoryProvider);

  @override
  Future<List<ForumHallsModel>> build() async {
    return await _repo.getForumHallsTop();
  }
}

@Riverpod(keepAlive: true)
class ForumHalls extends _$ForumHalls {
  ForumRepository get _repo => ref.watch(forumRepositoryProvider);

  final int _pageSize = 10;
  int _currentPage = 1;

  @override
  PaginatedModel<ForumHallsModel> build() => const PaginatedModel();

  Future<void> load({String? query}) async {
    if (state.loading || state.finished) return;

    state = state.copyWith(loading: true);

    try {
      final newData = await _repo.getForumHalls(
        search: query,
        pageNumber: _currentPage,
        pageSize: _pageSize,
      );

      if (newData.isEmpty) {
        state = state.copyWith(
          data: _currentPage == 1 ? [] : state.data,
          initial: false,
          finished: true,
        );
      } else {
        state = state.copyWith(
          data: _currentPage == 1 ? newData : [...state.data, ...newData],
          initial: false,
          finished: newData.length < _pageSize,
        );
        _currentPage++;
      }
    } on Exception {
      state = state.copyWith(
        initial: false,
        error: true,
      );
    } finally {
      state = state.copyWith(
        loading: false,
      );
    }
  }
}

@riverpod
class ForumHall extends _$ForumHall {
  ForumRepository get _repo => ref.watch(forumRepositoryProvider);

  @override
  Future<ForumHallModel> build({required String id}) async {
    return await _repo.getForumHall(id);
  }
}

@riverpod
class ForumHallTiles extends _$ForumHallTiles {
  ForumRepository get _repo => ref.watch(forumRepositoryProvider);

  final int _pageSize = 10;
  int _currentPage = 1;

  @override
  PaginatedModel<ForumTileModel> build({required String id}) {
    return const PaginatedModel();
  }

  Future<void> load({String? query}) async {
    if (state.loading || state.finished) return;

    state = state.copyWith(loading: true);

    try {
      final newData = await _repo.getForumHallTiles(
        pageNumber: _currentPage,
        pageSize: _pageSize,
      );

      if (newData.isEmpty) {
        state = state.copyWith(
          data: _currentPage == 1 ? [] : state.data,
          initial: false,
          finished: true,
        );
      } else {
        state = state.copyWith(
          data: _currentPage == 1 ? newData : [...state.data, ...newData],
          initial: false,
          finished: newData.length < _pageSize,
        );
        _currentPage++;
      }
    } on Exception {
      state = state.copyWith(
        initial: false,
        error: true,
      );
    } finally {
      state = state.copyWith(
        loading: false,
      );
    }
  }
}
