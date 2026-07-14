import 'package:ava/common/values/imports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_page_params.freezed.dart';

@freezed
class MediaPageParams with _$MediaPageParams {
  const factory MediaPageParams({
    required ImageProvider<Object> image,
    @Default(true) bool canSave,
  }) = _MediaPageParams;
}
