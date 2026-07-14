import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_model.dart';

part 'ava_connect_model.freezed.dart';
part 'ava_connect_model.g.dart';

@freezed
class AvaConnectModel with _$AvaConnectModel {
  const factory AvaConnectModel({
    required int id,
    required int statusId,
    required String status,
    required List<AvaMessageModel> messages,
  }) = _AvaConnectModel;

  const AvaConnectModel._();

  factory AvaConnectModel.fromJson(Map<String, dynamic> json) =>
      _$AvaConnectModelFromJson(json);

  @override
  String toString() {
    return """AvaConnectModel(
    id: $id,
    statusId: $statusId,
    status: $status,
    messages: $messages
  )""";
  }
}
