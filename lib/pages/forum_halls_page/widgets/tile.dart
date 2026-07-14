part of '../forum_halls_page.dart';

class _Tile extends StatelessWidget {
  const _Tile({
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
      child: SizedBox(
        height: 64.h,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: CustomNetworkImage(
                url: hall.banner,
                height: 64.h,
                width: 98.w,
                fallback: 'assets/images/image2.png',
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
                    style: context.labelMedium.copyWith(
                      color: AppColors.onSecondary,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      if (hall.categoryName != null) ...[
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 85.w,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Text(
                            hall.categoryName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.labelSmall.copyWith(
                              color: AppColors.secondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: hall.rate.toString(),
                              style: context.labelSmall.copyWith(
                                color: AppColors.onSecondary,
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
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              formatCount(hall.followerCount),
                              style: context.labelMedium.copyWith(
                                color: AppColors.onSecondary,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            if (hall.followers != null &&
                                hall.followers!.isNotEmpty)
                              SizedBox(
                                width: (30.w +
                                    (math.min(hall.followers!.length - 1, 2) *
                                        15.w)),
                                height: 30.h,
                                child: Stack(
                                  children: [
                                    for (var i = 0;
                                        i < hall.followers!.length && i < 3;
                                        i++)
                                      Positioned(
                                        left: i * 15.w,
                                        child: Container(
                                          height: 30.h,
                                          width: 30.h,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: AppColors.blue14,
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                            border: Border.all(
                                              color: AppColors.white,
                                              width: 2.w,
                                            ),
                                            image: DecorationImage(
                                              image: customNetworkImageProvider(
                                                url: hall.followers![i]
                                                        .avatarUrl ??
                                                    'assets/images/user.png',
                                                fallback:
                                                    'assets/images/user.png',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
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
