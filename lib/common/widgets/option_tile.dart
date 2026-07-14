import 'package:ava/common/values/imports.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    this.enabled = true,
    this.title,
    required this.value,
    required this.hintText,
    required this.onTap,
    this.onDisabledTap,
    this.titleStyle,
    this.hintStyle,
    this.titleSpacing,
    this.trailing,
    this.padding,
    this.color,
    this.borderColor,
  });

  final bool enabled;
  final String? title;
  final TextStyle? titleStyle;
  final double? titleSpacing;
  final String? value;
  final String hintText;
  final TextStyle? hintStyle;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final VoidCallback onTap;
  final VoidCallback? onDisabledTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titleStyle ??
                context.labelMedium.copyWith(
                  color: AppColors.onSecondary,
                ),
          ),
          SizedBox(height: titleSpacing ?? 10.h),
        ],
        GestureDetector(
          onTap: enabled ? onTap : onDisabledTap,
          child: Container(
            height: AppValues.textfieldHeight,
            padding: padding ?? EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
            decoration: ShapeDecoration(
              color: color ?? AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(
                  color: borderColor ?? AppColors.outlineVariant,
                  width: 1.0.w,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? hintText,
                    style: hintStyle ??
                        (value != null
                            ? context.bodyLarge.copyWith(
                                color: AppColors.onBackground,
                              )
                            : context.labelMedium.copyWith(
                                color: AppColors.grey3,
                              )),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
