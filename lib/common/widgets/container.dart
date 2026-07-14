import 'package:ava/common/values/imports.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.label,
    this.hintText,
    this.labelText,
    this.height,
    this.width,
    this.padding = EdgeInsets.zero,
    this.hasIcon = false,
    this.isRequired = false,
    this.textDirection,
    this.onTap,
  })  : assert(
          label != null || hintText != null || labelText != null,
          'label, hintText, and labelText cannot be null at the same time',
        ),
        assert(
          label == null || hintText == null || labelText == null,
          'label, hintText, and labelText cannot be provided at the same time',
        ),
        assert(
          hintText != null || isRequired == false,
          'hintText must be provided if isRequired is true',
        );

  final Widget? label;
  final String? hintText;
  final String? labelText;
  final double? height;
  final double? width;
  final EdgeInsets padding;
  final bool hasIcon;
  final bool isRequired;
  final TextDirection? textDirection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = labelText != null || hintText != null
        ? Text(
            labelText ?? "$hintText${isRequired ? '*' : ''}",
            maxLines: 1,
            textDirection: textDirection,
            style: context.bodyLarge.copyWith(
              color: labelText != null
                  ? AppColors.primary
                  : AppColors.onBackground,
            ),
          )
        : label ?? const SizedBox.shrink();
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: height ?? AppValues.textfieldHeight,
        maxHeight: height ?? AppValues.textfieldHeight,
        minWidth: width ?? AppValues.textfieldHeight,
        maxWidth: width ?? double.infinity,
      ),
      child: Material(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(
                  color: labelText != null
                      ? AppColors.primary
                      : AppColors.outlineVariant,
                ),
              ),
            ),
            child: Padding(
              padding: padding,
              child: hasIcon
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          child,
                          const Spacer(),
                          SizedBox(width: 10.w),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.onBackground,
                          ),
                        ],
                      ),
                    )
                  : Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
