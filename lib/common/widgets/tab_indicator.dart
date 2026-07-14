import 'package:ava/common/values/imports.dart';

class CustomTabIndicator extends Decoration {
  const CustomTabIndicator({
    this.borderSide = const BorderSide(
      width: 2.0,
      color: Colors.white,
    ),
    this.insets = EdgeInsets.zero,
  });

  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;

  @override
  UnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return UnderlinePainter(this, onChanged);
  }
}

class UnderlinePainter extends BoxPainter {
  UnderlinePainter(
    this.decoration,
    VoidCallback? onChanged,
  ) : super(onChanged);

  final CustomTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = offset & configuration.size!;
    final Paint paint = decoration.borderSide.toPaint();
    paint.strokeCap = StrokeCap.square;

    final Rect indicator = decoration.insets
        .resolve(configuration.textDirection)
        .deflateRect(rect);

    canvas.drawLine(
      Offset(
        indicator.left,
        indicator.bottom - decoration.borderSide.width / 2.0,
      ),
      Offset(
        indicator.right,
        indicator.bottom - decoration.borderSide.width / 2.0,
      ),
      paint,
    );
  }
}
