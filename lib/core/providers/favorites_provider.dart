import 'package:ava/core/services/favorites_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_provider.g.dart';

@riverpod
FavoritesRepository favoritesRepository(FavoritesRepositoryRef ref) {
  return FavoritesRepository(ref);
}

@riverpod
class Favorites extends _$Favorites {
  late final FavoritesRepository _favoritesRepo;

  @override
  Future<void> build() async {
    _favoritesRepo = ref.watch(favoritesRepositoryProvider);
  }
}
