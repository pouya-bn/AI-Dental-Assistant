import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveFile(File file) async {
  final status = await Permission.photos.status;
  if (status.isDenied) {
    await Permission.photos.request();
    if (status.isDenied) {
      logger.w('Storage permission denied');
      await openAppSettings();
    }
  } else if (status.isPermanentlyDenied) {
    logger.w('Storage permission denied');
    await openAppSettings();
  } else {
    try {
      Directory dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
      } else {
        final path = await getDownloadsDirectory();
        if (path != null) {
          dir = Directory(path.path);
        } else {
          dir = await getApplicationDocumentsDirectory();
        }
      }
      final newFile = File(
          '${dir.path}/${AppStrings.appNameEn}/${file.path.split('/').last}');
      await file.copy(newFile.path);

      logger('File saved to: ${newFile.path}');
      AppToast.showSuccess(
        title: 'فایل با موفقیت ذخیره شد',
      );
    } catch (e) {
      logger.e('Failed to save file: $e');
      AppToast.showError(
        title: 'خطا در ذخیره فایل',
        description: 'لطفا دوباره تلاش کنید',
      );
    }
  }
}
