import 'package:ava/common/values/imports.dart';
import 'package:ava/core/services/splash_repository.dart';
import 'package:ava/core/utils/ensure_wait.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_provider.g.dart';

@riverpod
SplashRepository splashRepository(SplashRepositoryRef ref) {
  return SplashRepository(ref);
}

@riverpod
class Splash extends _$Splash {
  @override
  Future<void> build() async {
    final List<dynamic> results = await ensureWait(
      duration: const Duration(seconds: 3),
      futures: [
        PackageInfo.fromPlatform(),
      ],
    );

    final packageInfo = results[0] as PackageInfo;
    AppStrings.appVersion = packageInfo.version;
  }
}
