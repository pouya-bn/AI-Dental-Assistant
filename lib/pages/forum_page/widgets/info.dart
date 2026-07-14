part of '../forum_page.dart';

class _Info extends ConsumerWidget {
  const _Info();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: CustomSection(
        label: const LabelModel(
          title: 'اطلاعات برنامه',
          icon: 'assets/images/svg/story.svg',
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'کارگردان',
                  style: context.labelSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  'علی حاتمی',
                  style: context.labelSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  'زمان برنامه',
                  style: context.labelSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '1 ساعت و 50 دقیقه',
                  style: context.labelSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  'موضوع',
                  style: context.labelSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  'آموزش',
                  style: context.labelSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
