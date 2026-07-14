import 'package:ava/common/values/imports.dart';

export 'package:ava/core/models/label_model.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    super.key,
    required this.label,
    this.style,
    this.color,
    this.margin,
    this.onShowAll,
    this.trailing,
  });

  final LabelModel label;
  final TextStyle? style;
  final Color? color;
  final double? margin;
  final VoidCallback? onShowAll;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    if (onShowAll != null || trailing != null) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: margin ?? 0,
        ),
        child: Row(
          children: [
            Expanded(
              child: _Text(
                icon: label.icon,
                label: label.title,
                style: style,
                iconColor: color,
              ),
            ),
            if (onShowAll != null)
              GestureDetector(
                onTap: onShowAll,
                child: Text(
                  'مشاهده همه',
                  style: context.labelSmall.copyWith(
                    color: AppColors.onPrimary,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            if (trailing != null) trailing!,
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: margin ?? 0,
      ),
      child: _Text(
        icon: label.icon,
        label: label.title,
        style: style,
        iconColor: color,
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    this.icon,
    required this.label,
    this.style,
    this.iconColor,
  });

  final String? icon;
  final String label;
  final TextStyle? style;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: style ??
            context.labelMedium.copyWith(
              color: iconColor ?? AppColors.tertiary,
            ),
        children: [
          if (icon != null)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: CustomSvg(
                  icon!,
                  color: iconColor ?? AppColors.tertiary,
                ),
              ),
            ),
          TextSpan(
            text: label,
          ),
        ],
      ),
    );
  }
}
