import 'package:freezed_annotation/freezed_annotation.dart';

part 'label_model.freezed.dart';

@freezed
class LabelModel with _$LabelModel {
  const factory LabelModel({
    required String title,
    String? icon,
  }) = _LabelModel;
}
