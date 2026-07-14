import 'package:ava/common/values/imports.dart';
import 'package:flutter/services.dart';

Future<void> cacheImageAssets(BuildContext context) async {
  final images = await _getImageAssets();
  for (final image in images) {
    try {
      if (context.mounted) {
        precacheImage(AssetImage(image), context);
      }
    } catch (e) {
      logger.t('Precache failed for image: $image');
    }
  }
}

Future<List<String>> _getImageAssets() async {
  try {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    return manifest.listAssets().where((string) {
      return string.startsWith('assets/images/') &&
          !string.startsWith('assets/images/svg/');
    }).toList();
  } catch (e, t) {
    logger.t(
      'Failed to load image assets: $e',
      stackTrace: t,
    );
    return [];
  }
}
