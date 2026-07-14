part of '../forum_page.dart';

class _ForumTitle extends HookWidget {
  const _ForumTitle();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      sliver: SliverToBoxAdapter(
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
                  Text(
                    'آموزش مسواک زدن با آوا',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.headlineSmall.copyWith(
                      color: AppColors.onSecondary,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          '2 فصل و 12 قسمت',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.labelSmall.copyWith(
                            color: AppColors.white50,
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
      ),
    );
  }
}
