import 'dart:async';

Future<List<T>> ensureWait<T>({
  required List<Future<T>> futures,
  required Duration duration,
}) async {
  final start = DateTime.now();
  final results = await Future.wait(futures);
  final elapsed = DateTime.now().difference(start).inMilliseconds;
  final remaining = duration.inMilliseconds - elapsed;
  if (remaining > 0) {
    await Future.delayed(Duration(milliseconds: remaining));
  }
  return results;
}
