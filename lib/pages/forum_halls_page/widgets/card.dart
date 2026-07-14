part of '../forum_halls_page.dart';

class _Card extends StatelessWidget {
  const _Card({
    required this.hall,
  });

  final ForumHallsModel hall;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.push(
          AppRoutes.forumHall,
          extra: hall.id,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 15.h,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.blue14,
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: customNetworkImageProvider(
              url: hall.banner,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hall.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.labelMedium.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.h),
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: hall.rate.toString(),
                    style: context.labelSmall.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: CustomSvg(
                        'assets/images/svg/star.svg',
                        height: 12.sp,
                        width: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            if (hall.followers != null && hall.followers!.isNotEmpty)
              SizedBox(
                width:
                    (30.w + (math.min(hall.followers!.length - 1, 2) * 15.w)),
                height: 30.h,
                child: Stack(
                  children: [
                    for (var i = 0; i < hall.followers!.length && i < 3; i++)
                      Positioned(
                        left: i * 15.w,
                        child: Container(
                          height: 30.h,
                          width: 30.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColors.blue14,
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: AppColors.white,
                              width: 2.w,
                            ),
                            image: DecorationImage(
                              image: customNetworkImageProvider(
                                url: hall.followers![i].avatarUrl ??
                                    'assets/images/user.png',
                                fallback: 'assets/images/user.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            if (hall.categoryName != null) ...[
              SizedBox(height: 5.h),
              Container(
                height: 20.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey4,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  hall.categoryName!,
                  style: context.labelSmall.copyWith(
                    color: AppColors.blue19,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
