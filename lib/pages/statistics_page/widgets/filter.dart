part of '../statistics_page.dart';

class _Filter extends HookWidget {
  const _Filter({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7.w),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Text(
          title,
          style: context.bodySmall.copyWith(
            color: isSelected ? AppColors.primary : AppColors.grey5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
