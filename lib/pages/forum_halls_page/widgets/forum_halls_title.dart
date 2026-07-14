part of '../forum_halls_page.dart';

class _ForumHallsTitle extends HookWidget {
  const _ForumHallsTitle();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Container(
            width: 46.h,
            height: 46.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.onPrimary,
                width: 2.w,
              ),
            ),
            child: Center(
              child: CustomSvg(
                'assets/images/svg/messages.svg',
                height: 24.h,
                width: 24.h,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'آموزش بهداشت با آوا',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.headlineSmall.copyWith(
                          color: AppColors.onSecondary,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    const CustomSvg(
                      'assets/images/svg/send2.svg',
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        '22,000 نفر دنبال کننده',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.labelSmall.copyWith(
                          color: AppColors.tertiary,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
