import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_model.freezed.dart';
part 'about_model.g.dart';

@freezed
class AboutModel with _$AboutModel {
  const factory AboutModel({
    String? aboutUs,
    String? rule,
    String? privacy,
  }) = _AboutModel;

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);
}
