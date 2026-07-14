import 'package:ava/common/values/imports.dart';

class CustomRadio<T> extends StatefulWidget {
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.fillColor,
    this.borderColor,
  });

  final T value;
  final T groupValue;
  final void Function(T?) onChanged;
  final Color? fillColor;
  final Color? borderColor;

  @override
  State<CustomRadio<T>> createState() => _CustomRadioState();
}

class _CustomRadioState<T> extends State<CustomRadio<T>> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);
    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: CustomPaint(
        size: Size(16.h, 16.h),
        painter: _RadioPainter(
          fillColor: selected
              ? (widget.fillColor ?? AppColors.green1)
              : Colors.transparent,
          borderColor: widget.borderColor ?? AppColors.white,
        ),
      ),
    );
  }
}

class _RadioPainter extends CustomPainter {
  _RadioPainter({
    required this.fillColor,
    required this.borderColor,
  });

  Color fillColor;
  Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintFill = Paint();
    Paint paintBorderLine = Paint();
    paintFill.color = fillColor;
    paintBorderLine.color = borderColor;
    paintFill.style = PaintingStyle.fill;
    paintBorderLine.style = PaintingStyle.stroke;
    paintFill.strokeCap = StrokeCap.round;
    paintFill.strokeJoin = StrokeJoin.round;
    paintFill.strokeWidth = 0;
    paintBorderLine.strokeCap = StrokeCap.round;
    paintBorderLine.strokeJoin = StrokeJoin.round;
    paintBorderLine.strokeWidth = 1.5;
    Offset offset = Offset(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(offset, size.width * 0.3, paintFill);
    canvas.drawCircle(offset, size.width * 0.5, paintBorderLine);
  }

  @override
  bool shouldRepaint(covariant _RadioPainter oldDelegate) {
    return true;
  }
}
