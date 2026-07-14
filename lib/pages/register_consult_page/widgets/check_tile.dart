part of '../register_consult_page.dart';

class _CheckTile extends StatelessWidget {
  const _CheckTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(value),
      child: Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.blue20,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodyMedium.copyWith(
                  color: AppColors.blue20,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            CustomCheckbox(
              value: value,
              onChanged: onChanged,
              borderColor: AppColors.blue20,
              fillColor: AppColors.blue20,
            ),
          ],
        ),
      ),
    );
  }
}
