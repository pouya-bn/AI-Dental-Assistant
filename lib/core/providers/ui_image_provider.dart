import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:ava/common/values/imports.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_converter/flutter_image_converter.dart';
import 'package:image/image.dart' as img;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ui_image_provider.g.dart';

@riverpod
class UiImage extends _$UiImage {
  @override
  FutureOr<ui.Image> build(String url, List<Offset> points) async {
    try {
      final response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.data == null) return _error();
      final src = img.decodeImage(
        Uint8List.fromList(response.data!),
      );
      if (src == null) return _error();
      return await _drawPolygon(src, points);
    } catch (e) {
      return _error();
    }
  }

  FutureOr<ui.Image> _error() {
    return Future.error(
      'Failed to get image',
      StackTrace.current,
    );
  }
}

Future<ui.Image> _drawPolygon(
  img.Image image,
  List<Offset> points,
) async {
  final imgPoints = points
      .map((point) => img.Point(point.dx.toInt(), point.dy.toInt()))
      .toList();

  final scale = (image.width + image.height) / 2 / 1000.0;
  final thickness = (7 * scale).toInt();
  final radius = (10 * scale).toInt();

  img.drawPolygon(
    image,
    vertices: imgPoints,
    thickness: thickness,
    color: img.ColorRgb8(255, 0, 0),
  );

  for (final point in imgPoints) {
    img.fillCircle(
      image,
      x: point.xi,
      y: point.yi,
      radius: radius,
      color: img.ColorRgb8(255, 255, 0),
    );
  }

  return await image.uiImage;
}
