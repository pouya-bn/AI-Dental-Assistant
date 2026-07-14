import 'dart:io';

import 'package:ava/core/utils/file_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'consult_model.freezed.dart';
part 'consult_model.g.dart';

@freezed
class ConsultModel with _$ConsultModel {
  const factory ConsultModel({
    DateTime? time,
    String? brief,
    @FileOrConverter() File? document,
  }) = _ConsultModel;

  factory ConsultModel.fromJson(Map<String, dynamic> json) =>
      _$ConsultModelFromJson(json);
}
