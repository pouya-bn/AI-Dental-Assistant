import 'package:ava/common/values/imports.dart';

class CustomSection extends StatelessWidget {
  const CustomSection({
    super.key,
    required this.child,
    this.label,
    this.padding,
    this.labelMargin,
  });

  final Widget child;
  final LabelModel? label;
  final double? labelMargin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 30.h,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            CustomLabel(
              label: label!,
              margin: labelMargin,
            ),
            SizedBox(height: 20.h),
          ],
          child,
        ],
      ),
    );
  }
}
