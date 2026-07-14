part of '../forum_halls_page.dart';

class _Rating extends StatelessWidget {
  const _Rating();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Row(
          children: [
            CustomLabel(
              label: const LabelModel(
                icon: 'assets/images/svg/message.svg',
                title: '8765 مطلب آماده خواندن',
              ),
              style: context.labelSmall.copyWith(
                color: AppColors.tertiary,
              ),
            ),
            const Spacer(),
            Text(
              'درباره این بلاگ',
              style: context.labelSmall.copyWith(
                color: AppColors.tertiary,
              ),
            ),
            SizedBox(width: 5.w),
            Icon(
              Icons.chevron_right_rounded,
              size: 16.sp,
              color: AppColors.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
