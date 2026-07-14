import 'dart:io';

import 'package:ava/core/utils/file_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_entry_model.freezed.dart';
part 'file_entry_model.g.dart';

@freezed
class FileEntryModel with _$FileEntryModel {
  const factory FileEntryModel(
    String field,
    @FileOrConverter() File? file,
  ) = _FileEntryModel;

  factory FileEntryModel.fromJson(Map<String, dynamic> json) =>
      _$FileEntryModelFromJson(json);
}
