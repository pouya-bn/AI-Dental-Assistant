import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/radio.dart';

class RadioTile<T> extends StatelessWidget {
  const RadioTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.decoration,
    this.height,
  });

  final String title;
  final T value;
  final T groupValue;
  final void Function(T?) onChanged;
  final double? height;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: decoration?.borderRadius as BorderRadius?,
      child: Container(
        height: height ?? 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: decoration,
        child: Row(
          children: [
            Text(
              title,
              style: context.labelSmall.copyWith(
                color: AppColors.onPrimary,
              ),
            ),
            const Spacer(),
            CustomRadio<T>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            )
          ],
        ),
      ),
    );
  }
}
