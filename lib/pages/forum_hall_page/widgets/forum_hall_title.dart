part of '../forum_hall_page.dart';

class _ForumHallTitle extends HookWidget {
  const _ForumHallTitle({
    required this.hall,
  });

  final ForumHallModel hall;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            CircleAvatar(
              radius: 23.h,
              backgroundColor: AppColors.blue4,
              backgroundImage: customNetworkImageProvider(
                url: hall.avatar,
                fallback: 'assets/images/image2.png',
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.onPrimary,
                    width: 2.w,
                  ),
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
                    hall.name,
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
                          '${hall.followerCount} دنبال کننده  |  ${hall.titleCount} محتوا',
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
