import 'dart:async';
import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveImageToGallery(ImageProvider<Object> imageProvider) async {
  if (imageProvider is NetworkImage) {
    await saveNetworkImageToGallery(imageProvider.url);
  } else if (imageProvider is CachedNetworkImageProvider) {
    await saveNetworkImageToGallery(imageProvider.url);
  } else if (imageProvider is FileImage) {
    await saveFileImageToGallery(imageProvider.file);
  } else if (imageProvider is AssetImage) {
    await saveAssetImageToGallery(imageProvider.assetName);
  } else {
    AppToast.showError(
      title: 'خطا',
      description: 'نوع تصویر پشتیبانی نمی‌شود.',
    );
  }
}

Future<void> saveNetworkImageToGallery(String url) async {
  try {
    final path = await _getPath();
    await Dio().download(url, path);
    await _saveImageToGallery(path);
  } catch (e, t) {
    logger.e(e, stackTrace: t);
    AppToast.showError(
      title: 'خطا',
      description: 'ذخیره تصویر با خطا مواجه شد. لطفا دوباره تلاش کنید.',
    );
  }
}

Future<void> saveFileImageToGallery(File imageFile) async {
  try {
    final path = await _getPath();
    final file = await imageFile.copy(path);
    await _saveImageToGallery(file.path);
  } catch (e, t) {
    logger.e(e, stackTrace: t);
    AppToast.showError(
      title: 'خطا',
      description: 'ذخیره تصویر با خطا مواجه شد. لطفا دوباره تلاش کنید.',
    );
  }
}

Future<void> saveAssetImageToGallery(String assetName) async {
  try {
    final byteData = await rootBundle.load(assetName);
    final path = await _getPath();
    final file = await File(path).writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    await _saveImageToGallery(file.path);
  } catch (e, t) {
    logger.e(e, stackTrace: t);
    AppToast.showError(
      title: 'خطا',
      description: 'ذخیره تصویر با خطا مواجه شد. لطفا دوباره تلاش کنید.',
    );
  }
}

Future<void> _saveImageToGallery(String path) async {
  final hasAccess = await Gal.hasAccess(toAlbum: true);
  if (!hasAccess) {
    final granted = await Gal.requestAccess(toAlbum: true);
    if (!granted) {
      AppToast.showError(
        title: 'خطا',
        description: 'برای ذخیره تصویر در گالری، دسترسی لازم را بدهید.',
      );
      return;
    }
  }
  await Gal.putImage(path, album: AppStrings.appNameEn);

  AppToast.showSuccess(
    title: 'تصویر با موفقیت در گالری ذخیره شد',
  );
}

Future<String> _getPath() async {
  final tempDir = await getTemporaryDirectory();
  return '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
}
