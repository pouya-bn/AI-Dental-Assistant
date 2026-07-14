import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/api_response_model.dart';
import 'package:ava/core/models/ava_connect_model.dart';
import 'package:ava/core/providers/chat_provider.dart';
import 'package:ava/core/providers/storage_provider.dart';
import 'package:signalr_core/signalr_core.dart';

class SocketService {
  SocketService(this.ref);

  Ref ref;

  String get _baseUrl => AppStrings.socketBaseUrl;

  HubConnection? _socket;

  bool get isConnected =>
      _socket != null && _socket!.state == HubConnectionState.connected;

  Future<void> connect() async {
    try {
      if (isConnected) {
        logger('Websocket is already connected');
        return;
      }

      final token = ref.watch(secureStorageProvider).get(AppStrings.tokenKey);
      if (token == null) {
        logger.e('Token is null');
        return;
      }

      _socket = HubConnectionBuilder()
          .withUrl(
            _baseUrl,
            HttpConnectionOptions(
              logging: (level, message) => logger.log(level.toLevel(), message),
              transport: HttpTransportType.webSockets,
              accessTokenFactory: () async => token,
              skipNegotiation: true,
            ),
          )
          .build();

      await _socket?.start();

      _socket?.on('Connect', (messages) async {
        if (messages == null || messages.isEmpty) {
          logger.w('Websocket [Connect] returned no messages.');
          return;
        }
        final responseJson = messages.first as Map<String, dynamic>?;
        if (responseJson != null) {
          final apiResponse = ApiResponseModel.fromJson(responseJson);
          if (apiResponse.succeeded) {
            logger('Websocket [Connect] Response: ${apiResponse.toString()}');
            final connect = AvaConnectModel.fromJson(
              apiResponse.data as Map<String, dynamic>,
            );
            await ref.read(chatRepositoryProvider).initialize(connect.messages);
          } else {
            logErrors(apiResponse.errors);
          }
        } else {
          logger.w('Websocket [Connect] returned invalid response');
        }
      });

      _socket?.on('AvaChats', (messages) {
        // TODO: Handle AvaChats
      });

      _socket?.onreconnecting((callback) {
        logger.w('Websocket Reconnecting: $callback');
      });

      _socket?.onreconnected((connectionId) {
        logger('Websocket Reconnected: $connectionId');
      });

      _socket?.onclose((error) {
        logger.e('Websocket Disconnected: $error');
      });
    } catch (e) {
      logger.e('Failed to connect websocket: $e');
    }
  }

  Stream<T?> stream<T>({
    required String method,
    List<dynamic>? args,
  }) async* {
    try {
      if (!isConnected) {
        await connect();
      }
      yield* _socket!.stream<T>(method, args: args);
    } catch (e) {
      logger.e('Failed to stream websocket data: $e');
      yield* const Stream.empty();
    }
  }

  void disconnect() {
    try {
      if (isConnected) {
        _socket!.stop();
        _socket = null;
      }
      logger.w('Websocket Disconnected');
    } catch (e) {
      logger.e('Failed to disconnect websocket: $e');
    }
  }

  Future<dynamic> invoke({
    required String method,
    List<dynamic>? args,
  }) async {
    try {
      if (!isConnected) {
        await connect();
      }
      logger('Websocket Sent:\n$args');
      return await _socket?.invoke(
        method,
        args: args,
      );
    } catch (e) {
      logger.e('Failed to send websocket data: $e');
    }
  }
}
