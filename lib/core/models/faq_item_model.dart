import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_item_model.freezed.dart';
part 'faq_item_model.g.dart';

@freezed
class FaqItemModel with _$FaqItemModel {
  const factory FaqItemModel({
    required int id,
    required int order,
    required String question,
    required String answer,
  }) = _FaqItemModel;

  factory FaqItemModel.fromJson(Map<String, dynamic> json) =>
      _$FaqItemModelFromJson(json);
}
