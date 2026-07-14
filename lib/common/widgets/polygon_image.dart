import 'dart:ui' as ui;

import 'package:ava/common/values/imports.dart';
import 'package:ava/core/providers/ui_image_provider.dart';

class PolygonImage extends ConsumerWidget {
  const PolygonImage({
    super.key,
    required this.imageUrl,
    required this.points,
  });

  final String imageUrl;
  final List<Offset> points;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(uiImageProvider(imageUrl, points));
    return Center(
      child: image.when(
        data: (image) => CustomPaint(
          painter: _ImagePainter(image),
          child: AspectRatio(
            aspectRatio: image.width / image.height,
            child: const SizedBox.expand(),
          ),
        ),
        loading: () => const Loading(),
        error: (_, __) => const CustomError(),
      ),
    );
  }
}

class _ImagePainter extends CustomPainter {
  _ImagePainter(this.image);

  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    paintImage(
      canvas: canvas,
      image: image,
      rect: Offset.zero & size,
      fit: BoxFit.contain,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
