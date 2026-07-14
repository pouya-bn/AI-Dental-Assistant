part of '../forum_page.dart';

class _Episodes extends HookWidget {
  const _Episodes();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30.h,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                icon: const CustomSvg(
                  'assets/images/svg/play.svg',
                ),
                label: Text(
                  'پخش قسمت اول',
                  style: context.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              AppStrings.loremIpsum2,
              style: context.bodySmall.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w200,
                height: 2,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              '12 فروردین 1402  |  45 دقیقه  | کیفیت HD',
              style: context.labelSmall.copyWith(
                color: AppColors.tertiary,
                height: 2,
              ),
            ),
            CustomDivider(height: 40.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, __) => SizedBox(height: 30.h),
              itemBuilder: (context, index) {
                return const _EpisodeTile();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EpisodeTile extends StatelessWidget {
  const _EpisodeTile();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'حرفه‌ای باش\nفصل 2  |  قسمت 1',
              style: context.labelMedium.copyWith(
                color: Colors.white,
                height: 1.5,
              ),
            ),
            SizedBox(height: 8.h),
            DefaultTextStyle(
              style: context.bodySmall.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w200,
                fontSize: 10.sp,
                height: 2,
              ),
              child: ReadMoreText(
                AppStrings.loremIpsum2,
                trimMode: TrimMode.Line,
                trimLines: 2,
                trimCollapsedText: 'بیشتر',
                trimExpandedText: 'کمتر',
                colorClickableText: AppColors.tertiary,
                lessStyle: context.bodySmall.copyWith(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.w200,
                  fontSize: 10.sp,
                ),
                moreStyle: context.bodySmall.copyWith(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.w200,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
