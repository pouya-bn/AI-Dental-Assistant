import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._(this._storage, this._cache);

  late final FlutterSecureStorage _storage;
  late final Map<String, String> _cache;

  @override
  String toString() {
    return """$SecureStorage(
      _storage: $_storage,
      _cache: $_cache,
    )""";
  }

  static Future<SecureStorage> instance({
    required Set<String> keys,
  }) async {
    const storage = FlutterSecureStorage();
    final cache = <String, String>{};
    await Future.wait(
      keys.map((key) async {
        final value = await storage.read(key: key);
        if (value != null) {
          cache[key] = value;
        }
      }),
    );
    return SecureStorage._(storage, cache);
  }

  String? get(String key) => _cache[key];

  Future<void> write(String key, String value) async {
    _cache[key] = value;
    return await _storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    _cache.remove(key);
    return await _storage.delete(key: key);
  }
}
