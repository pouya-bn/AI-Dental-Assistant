import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_model.freezed.dart';

@freezed
class PaginatedModel<T> with _$PaginatedModel<T> {
  const factory PaginatedModel({
    @Default([]) List<T> data,
    @Default(true) bool initial,
    @Default(false) bool loading,
    @Default(false) bool finished,
    @Default(false) bool error,
  }) = _PaginatedModel<T>;
}
