import 'package:ava/core/models/api_response_model.dart';
import 'package:logger/logger.dart';

final logger = _AppLogger();

class _AppLogger {
  Logger _logger({bool trace = false}) => Logger(
        printer: PrettyPrinter(
          methodCount: trace ? 11 : 0,
          lineLength: 100,
          colors: true,
        ),
      );

  /// General log - defaults to info level
  void call(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      i(
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );

  /// Log with level
  void log(
    Level level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger(trace: stackTrace != null).log(
        level,
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );

  /// Info log
  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger(trace: stackTrace != null).i(
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );

  /// Trace log
  void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger(trace: stackTrace != null).t(
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );

  /// Debug log
  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger(trace: stackTrace != null).d(
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );

  /// Warning log
  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger(trace: stackTrace != null).w(
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );

  /// Error log
  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger(trace: stackTrace != null).e(
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );

  /// Fatal log
  void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger(trace: stackTrace != null).f(
        message,
        time: time,
        error: error,
        stackTrace: stackTrace,
      );
}

void logErrors(List<ErrorDetailModel>? errors) {
  if (errors != null) {
    for (final error in errors) {
      logger.e('Error ${error.code}: ${error.message}');
    }
  } else {
    logger.e(
      'Unknown error occurred',
      stackTrace: StackTrace.current,
    );
  }
}
