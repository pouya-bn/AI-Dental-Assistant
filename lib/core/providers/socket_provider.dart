import 'package:ava/core/services/socket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'socket_provider.g.dart';

@Riverpod(keepAlive: true)
SocketService socket(SocketRef ref) {
  final service = SocketService(ref);
  ref.onDispose(() => service.disconnect());
  return service;
}
