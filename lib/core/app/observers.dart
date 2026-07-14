import 'package:ava/common/values/imports.dart';

class AppObserver extends ProviderObserver {
  const AppObserver();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    logger.i(
      'Initialized [${provider.name ?? provider}] -> '
      '${value.toString()}',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    logger.w(
      'Disposed [${provider.name ?? provider}]',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.d(
      'Updated [${provider.name ?? provider}]: '
      '${previousValue.toString()} -> ${newValue.toString()}',
    );
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    logger.e(
      'Error [${provider.name ?? provider}]:\n$error',
      stackTrace: stackTrace,
    );
  }
}
