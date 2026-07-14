import 'package:ava/common/values/imports.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.fillColor,
    this.borderColor,
  });

  final bool value;
  final void Function(bool?) onChanged;
  final Color? fillColor;
  final Color? borderColor;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    bool selected = widget.value;
    return InkWell(
      onTap: () => widget.onChanged(selected ? null : !widget.value),
      child: CustomPaint(
        size: Size(16.h, 16.h),
        painter: _CheckboxPainter(
          fillColor: selected
              ? (widget.fillColor ?? AppColors.green1)
              : Colors.transparent,
          borderColor: widget.borderColor ?? AppColors.white,
          isSelected: selected,
        ),
      ),
    );
  }
}

class _CheckboxPainter extends CustomPainter {
  _CheckboxPainter({
    required this.fillColor,
    required this.borderColor,
    required this.isSelected,
  });

  final Color fillColor;
  final Color borderColor;
  final bool isSelected;

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

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(2.r));
    canvas.drawRRect(rRect, paintBorderLine);

    if (isSelected) {
      canvas.drawRRect(rRect, paintFill);

      Paint paintCheck = Paint();
      paintCheck.color = AppColors.white;
      paintCheck.style = PaintingStyle.stroke;
      paintCheck.strokeWidth = 2.0;
      paintCheck.strokeCap = StrokeCap.round;
      paintCheck.strokeJoin = StrokeJoin.round;

      Path path = Path();
      path.moveTo(size.width * 0.2, size.height * 0.5);
      path.lineTo(size.width * 0.4, size.height * 0.7);
      path.lineTo(size.width * 0.8, size.height * 0.3);
      canvas.drawPath(path, paintCheck);
    }
  }

  @override
  bool shouldRepaint(covariant _CheckboxPainter oldDelegate) {
    return true;
  }
}
