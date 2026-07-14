import 'package:auto_size_text/auto_size_text.dart';
import 'package:ava/common/values/imports.dart';

enum CustomButtonType {
  elevated,
  outlined,
  text,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.type = CustomButtonType.text,
    this.color,
    this.labelColor,
    this.labelStyle,
    this.padding,
    this.margin,
    this.height,
    this.width,
    this.size,
    this.isLoading = false,
    this.loadingColor,
    this.disabledBgColor,
    this.side,
    this.shape,
    this.borderColor,
    this.onTap,
  });

  final String label;
  final CustomButtonType type;
  final Color? color;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isLoading;
  final Color? loadingColor;
  final Color? disabledBgColor;
  final double? height;
  final double? width;
  final Size? size;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final Color? borderColor;
  final VoidCallback? onTap;

  factory CustomButton.elevated({
    required String label,
    Color? color,
    Color? labelColor,
    TextStyle? labelStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? height,
    double? width,
    Size? size,
    OutlinedBorder? shape,
    bool isLoading = false,
    Color? loadingColor,
    Color? disabledBgColor,
    VoidCallback? onTap,
  }) {
    return CustomButton(
      type: CustomButtonType.elevated,
      color: color,
      label: label,
      labelColor: labelColor,
      labelStyle: labelStyle,
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      size: size,
      shape: shape,
      isLoading: isLoading,
      loadingColor: loadingColor,
      disabledBgColor: disabledBgColor,
      onTap: onTap,
    );
  }

  factory CustomButton.text({
    required String label,
    Color? color,
    Color? labelColor,
    TextStyle? labelStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? height,
    double? width,
    Size? size,
    OutlinedBorder? shape,
    bool isLoading = false,
    Color? loadingColor,
    Color? disabledBgColor,
    VoidCallback? onTap,
  }) {
    return CustomButton(
      type: CustomButtonType.text,
      color: color,
      label: label,
      labelColor: labelColor,
      labelStyle: labelStyle,
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      size: size,
      shape: shape,
      isLoading: isLoading,
      loadingColor: loadingColor,
      disabledBgColor: disabledBgColor,
      onTap: onTap,
    );
  }

  factory CustomButton.outlined({
    required String label,
    Color? color,
    Color? labelColor,
    TextStyle? labelStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? height,
    double? width,
    Size? size,
    OutlinedBorder? shape,
    bool isLoading = false,
    Color? loadingColor,
    Color? disabledBgColor,
    BorderSide? side,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return CustomButton(
      type: CustomButtonType.outlined,
      color: color,
      label: label,
      labelColor: labelColor,
      labelStyle: labelStyle,
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      size: size,
      shape: shape,
      isLoading: isLoading,
      loadingColor: loadingColor,
      disabledBgColor: disabledBgColor,
      side: side,
      borderColor: borderColor,
      onTap: onTap,
    );
  }

  VoidCallback? get _onTap => isLoading ? null : onTap;

  Size get _size => size ?? Size(width ?? double.maxFinite, height ?? 55.h);

  Color get _color => isLoading
      ? AppColors.grey1
      : onTap != null
          ? color ?? AppColors.background
          : AppColors.grey1;

  Color get _disabledBgColor => disabledBgColor ?? AppColors.blue21;

  EdgeInsetsGeometry get _padding =>
      padding ?? EdgeInsets.symmetric(horizontal: 10.w);

  OutlinedBorder get _shape =>
      shape ??
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      );

  Widget _child(BuildContext context) {
    return isLoading
        ? Loading(
            color: loadingColor ?? AppColors.onBackground,
          )
        : AutoSizeText(
            label,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: labelStyle ??
                context.labelMedium.copyWith(
                  color: labelColor ?? AppColors.onBackground,
                ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: switch (type) {
        CustomButtonType.elevated => ElevatedButton(
            onPressed: _onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: _color,
              disabledBackgroundColor: _disabledBgColor,
              fixedSize: _size,
              shape: _shape,
              padding: _padding,
            ),
            child: _child(context),
          ),
        CustomButtonType.text => TextButton(
            onPressed: _onTap,
            style: TextButton.styleFrom(
              backgroundColor: _color,
              disabledBackgroundColor: _disabledBgColor,
              fixedSize: _size,
              shape: _shape,
              padding: _padding,
            ),
            child: _child(context),
          ),
        CustomButtonType.outlined => OutlinedButton(
            onPressed: _onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: _color,
              disabledBackgroundColor: _disabledBgColor,
              fixedSize: _size,
              shape: _shape,
              padding: _padding,
              side: side ??
                  BorderSide(
                    color: borderColor ?? AppColors.primary,
                    width: 1.w,
                  ),
            ),
            child: _child(context),
          )
      },
    );
  }
}
