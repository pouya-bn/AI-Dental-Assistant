part of '../forum_halls_page.dart';

class _AboutClinic extends StatelessWidget {
  const _AboutClinic();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'شماره نظام پزشکی: 12345',
          style: context.labelSmall.copyWith(
            color: AppColors.onPrimary,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'کلینیک دندانپزشکی دکتر رضا ملا',
          style: context.labelSmall.copyWith(
            color: AppColors.onPrimary,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'درمان مشکلات لثه، ایمپلنت',
          style: context.labelSmall.copyWith(
            color: AppColors.onPrimary,
          ),
        ),
      ],
    );
  }
}
