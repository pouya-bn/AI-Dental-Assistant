import 'package:ava/common/values/imports.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    this.style,
    this.onTap,
  });

  final TextStyle? style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add,
            color: AppColors.blue14,
            size: 16.w,
          ),
          Text(
            'اضافه کردن',
            style: style ??
                context.labelSmall.copyWith(
                  color: AppColors.blue14,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
