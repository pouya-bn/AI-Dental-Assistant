import 'dart:io';

import 'package:ava/core/utils/logger.dart';
import 'package:ava/core/utils/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

final _imagePicker = ImagePicker();

Future<File?> pickImage() async {
  File? image;
  try {
    final result = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (result != null) {
      image = File(result.path);
    }
  } catch (e) {
    logger.e(e);
    AppToast.showError(
      title: 'انتخاب فایل با خطا مواجه شد',
    );
  }
  return image;
}

Future<File?> pickFile() async {
  File? file;
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
    }
  } catch (e) {
    logger.e(e);
    AppToast.showError(
      title: 'انتخاب فایل با خطا مواجه شد',
    );
  }
  return file;
}
