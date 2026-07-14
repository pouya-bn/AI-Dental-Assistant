import 'package:ava/common/values/imports.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.keyboardType,
    this.style,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.suffixIcon,
    this.displayError = false,
    this.displaySuccess = false,
    this.obscureText = false,
    this.enabled,
    this.scrollPadding,
    this.initialValue,
    this.borderRadius,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.contentPadding,
    this.fillColor,
    this.autofocus = false,
    this.onTap,
    this.minLines,
    this.maxLines = 1,
    this.isRequired = false,
    this.textDirection,
    this.height,
    this.filled = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Widget? suffixIcon;
  final bool displayError;
  final bool displaySuccess;
  final bool obscureText;
  final bool? enabled;
  final EdgeInsets? scrollPadding;
  final String? initialValue;
  final BorderRadius? borderRadius;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool autofocus;
  final VoidCallback? onTap;
  final int? minLines;
  final int? maxLines;
  final bool isRequired;
  final TextDirection? textDirection;
  final double? height;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(8.r);
    getColor(Color fallbackColor) {
      if (displaySuccess) {
        return AppColors.primary;
      } else if (displayError) {
        return AppColors.error;
      } else {
        return fallbackColor;
      }
    }

    return Theme(
      data: context.theme.copyWith(
        inputDecorationTheme: context.theme.inputDecorationTheme.copyWith(
          constraints: BoxConstraints(
            minHeight: height ?? AppValues.textfieldHeight,
            maxHeight: height ?? AppValues.textfieldHeight,
          ),
          filled: filled,
          fillColor: fillColor ?? AppColors.background,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: labelStyle ??
              context.labelMedium.copyWith(
                color: getColor(AppColors.onBackground),
              ),
          hintStyle: hintStyle ??
              context.labelMedium.copyWith(
                color: AppColors.grey3,
              ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: getColor(AppColors.outline),
                  width: 1.w,
                ),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: getColor(AppColors.outlineVariant),
                  width: 1.w,
                ),
              ),
          disabledBorder: disabledBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: getColor(AppColors.outlineVariant),
                  width: 1.w,
                ),
              ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: AppColors.error,
              width: 1.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: AppColors.error,
              width: 1.w,
            ),
          ),
          errorStyle: const TextStyle(
            color: AppColors.error,
          ),
        ),
      ),
      child: TextFormField(
        focusNode: focusNode,
        autofocus: autofocus,
        enabled: enabled,
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,
        initialValue: initialValue,
        keyboardType: keyboardType,
        obscureText: obscureText,
        minLines: minLines,
        maxLines: maxLines,
        textDirection: textDirection,
        scrollPadding: scrollPadding ?? EdgeInsets.zero,
        style: style ??
            context.bodyLarge.copyWith(
              color: AppColors.onBackground,
            ),
        decoration: InputDecoration(
          label: labelText != null
              ? Text(isRequired ? "$labelText*" : labelText!)
              : null,
          contentPadding: contentPadding ??
              EdgeInsetsDirectional.symmetric(
                horizontal: 10.w,
              ),
          hintText: labelText ?? hintText,
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIconConstraints,
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints,
        ),
      ),
    );
  }
}
