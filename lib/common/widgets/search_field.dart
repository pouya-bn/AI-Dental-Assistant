import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/textfield.dart';

class SearchField extends HookWidget {
  const SearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onClear,
    this.focusNode,
    this.enabled = true,
    this.autofocus = false,
    this.foregroundColor = AppColors.blue14,
    this.onFilterTap,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color foregroundColor;
  final VoidCallback? onFilterTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final focusNode = this.focusNode ?? useFocusNode();
    final isFocused = useState(false);
    useEffect(() {
      focusNode.addListener(() {
        isFocused.value = focusNode.hasFocus;
      });
      return null;
    }, const []);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: CustomTextField(
              height: AppValues.textfieldHeight,
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              onChanged: onChanged,
              autofocus: autofocus,
              filled: true,
              style: context.bodyMedium.copyWith(
                color: foregroundColor,
              ),
              hintText: 'جستجو',
              hintStyle: context.bodyMedium.copyWith(
                color: AppColors.grey3,
              ),
              prefixIcon: prefixIcon ??
                  GestureDetector(
                    onTap: onClear,
                    child: CustomSvg(
                      onClear != null
                          ? 'assets/images/svg/close_circle_outline.svg'
                          : 'assets/images/svg/search.svg',
                      color:
                          isFocused.value ? foregroundColor : AppColors.grey3,
                    ),
                  ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 46.h,
                minHeight: 24.h,
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
        if (onFilterTap != null) ...[
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 46.h,
              height: 46.h,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.outlineVariant,
                  width: 1.w,
                ),
              ),
              child: const Center(
                child: CustomSvg(
                  'assets/images/svg/filter2.svg',
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
