import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:ava/core/utils/file_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class AvaMessageModel with _$AvaMessageModel {
  @Assert('type != MessageType.picture || (fileUrl != null || file != null)',
      'Either fileUrl or file must be provided for picture messages')
  @Assert('type != MessageType.picture || !(fileUrl != null && file != null)',
      'Only one of fileUrl or file can be provided for picture messages')
  const factory AvaMessageModel({
    required int id,
    required bool isUserMessage,
    required String message,
    required MessageTypeModel type,
    DateTime? createdAt, // TODO: make required
    AvaReplyModel? repliedTo,
    String? fileUrl,
    @FileOrConverter() File? file,
    String? reactEmoji,
    List<String>? buttons,
  }) = _AvaMessageModel;

  const AvaMessageModel._();

  factory AvaMessageModel.fromJson(Map<String, dynamic> json) =>
      _$AvaMessageModelFromJson(json);

  factory AvaMessageModel.bot({
    required int id,
    required String message,
    required MessageTypeModel type,
    AvaReplyModel? repliedTo,
    String? fileUrl,
    File? file,
    String? reactEmoji,
    List<String>? buttons,
  }) =>
      AvaMessageModel(
        isUserMessage: false,
        createdAt: DateTime.now(),
        id: id,
        message: message,
        type: type,
        repliedTo: repliedTo,
        fileUrl: fileUrl,
        file: file,
        reactEmoji: reactEmoji,
        buttons: buttons,
      );
}

@freezed
class AvaReplyModel with _$AvaReplyModel {
  const factory AvaReplyModel({
    required int id,
    required String message,
    required bool isUserMessage,
    required MessageTypeModel type,
    DateTime? createdAt, // TODO: make required
  }) = _AvaReplyModel;

  factory AvaReplyModel.fromJson(Map<String, dynamic> json) =>
      _$AvaReplyModelFromJson(json);
}

@freezed
class MessageTypeModel with _$MessageTypeModel {
  const factory MessageTypeModel({
    required int id,
    required String name,
  }) = _MessageTypeModel;

  const MessageTypeModel._();

  factory MessageTypeModel.fromJson(Map<String, dynamic> json) =>
      _$MessageTypeModelFromJson(json);

  MessageType get toEnum => MessageType.values.firstWhere(
        (e) => e.id == id,
        orElse: () => MessageType.text,
      );
}
