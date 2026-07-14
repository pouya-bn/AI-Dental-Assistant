import 'package:ava/common/values/imports.dart';
import 'package:ava/core/providers/storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@Riverpod(keepAlive: true)
ApiService api(ApiRef ref) {
  final token = ref.watch(secureStorageProvider).get(AppStrings.tokenKey);
  if (token != null) {
    return ApiService.withToken(token);
  }
  return ApiService();
}
