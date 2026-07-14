part of '../find_doctor_page.dart';

class _Label extends StatelessWidget {
  const _Label({
    required this.title,
    required this.onShowAll,
  });

  final String title;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: context.headlineSmall.copyWith(
                color: AppColors.onPrimary,
                fontSize: 16.sp,
              ),
            ),
          ),
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
        ],
      ),
    );
  }
}
