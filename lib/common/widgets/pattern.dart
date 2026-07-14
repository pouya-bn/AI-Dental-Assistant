import 'package:ava/common/values/imports.dart';

class CustomPattern extends StatelessWidget {
  const CustomPattern({
    super.key,
    this.count = 32,
    this.space = 10.93,
    this.radius = 48.54,
    this.opacity = 0.3,
  });

  final int count;
  final double space;
  final double radius;
  final double opacity;

  factory CustomPattern.variant() {
    return const CustomPattern(
      space: 14.24,
      radius: 63.28,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        count: count,
        space: space,
        radius: radius,
        opacity: opacity,
      ),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter({
    required this.count,
    required this.space,
    required this.radius,
    required this.opacity,
  });

  final int count;
  final double space;
  final double radius;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final rect = Rect.fromCircle(
      center: Offset(centerX, centerY),
      radius: radius + (space * (count - 1)),
    );
    final gradient = LinearGradient(
      colors: [
        Colors.white.withOpacity(0.1 * opacity),
        Colors.white.withOpacity(0.5 * opacity),
        Colors.white.withOpacity(0.05 * opacity),
      ],
      stops: const [0, 0.46, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < count; i++) {
      final currentRadius = radius + (space * i);
      canvas.drawCircle(
        Offset(centerX, centerY),
        currentRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
