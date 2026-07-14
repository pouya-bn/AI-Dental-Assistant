import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

class FileConverter implements JsonConverter<File, String> {
  const FileConverter();

  @override
  File fromJson(String json) {
    return File(json);
  }

  @override
  String toJson(File file) {
    return file.path;
  }
}

class FileOrConverter implements JsonConverter<File?, String?> {
  const FileOrConverter();

  @override
  File? fromJson(String? json) {
    if (json == null) return null;
    return File(json);
  }

  @override
  String? toJson(File? file) {
    return file?.path;
  }
}
