import 'dart:io';

import 'package:ava/core/models/message_model.dart';
import 'package:ava/core/services/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(ChatRepositoryRef ref) {
  return ChatRepository(ref);
}

@Riverpod(keepAlive: true)
class Chat extends _$Chat {
  ChatRepository get _repo => ref.watch(chatRepositoryProvider);

  @override
  Stream<List<AvaMessageModel>> build() {
    return _repo.chatStream;
  }

  void sendText(String text) => _repo.sendText(text);

  void sendPicture(File file) => _repo.sendPicture(file);

  void saveAsPdf(AvaMessageModel message) => _repo.saveAsPdf(message);
}

@Riverpod(keepAlive: true)
class Typewriter extends _$Typewriter {
  ChatRepository get _repo => ref.watch(chatRepositoryProvider);

  @override
  void build() {}

  bool shouldType(int messageId) {
    return _repo.shouldType(messageId);
  }
}

@Riverpod(keepAlive: true)
class Buttons extends _$Buttons {
  ChatRepository get _repo => ref.watch(chatRepositoryProvider);

  @override
  void build() {}

  bool shouldShowButtons(int messageId) {
    return _repo.shouldShowButtons(messageId);
  }
}
