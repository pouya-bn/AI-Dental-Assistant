import 'package:ava/common/values/imports.dart';

class DoctorTile extends StatelessWidget {
  const DoctorTile({
    super.key,
    required this.id,
    required this.name,
    required this.studyField,
    required this.rating,
    required this.totalReviews,
    this.image,
  });

  final String id;
  final String name;
  final String? studyField;
  final double rating;
  final int totalReviews;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push(
        AppRoutes.doctor,
        extra: id,
      ),
      child: SizedBox(
        height: 100.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.h,
              width: 100.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.blue13,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: image != null
                  ? CustomNetworkImage(
                      url: image,
                      fallback: 'assets/images/user2.png',
                      fallbackFit: BoxFit.contain,
                    )
                  : Image.asset('assets/images/user2.png'),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.labelMedium.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                    if (studyField != null)
                      Text(
                        studyField!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.labelSmall.copyWith(
                          color: AppColors.tertiary,
                        ),
                      ),
                    Row(
                      children: [
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: CustomSvg(
                                    'assets/images/svg/star.svg',
                                    height: 12.sp,
                                    width: 12.sp,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: rating.toString(),
                                style: context.labelSmall.copyWith(
                                  color: AppColors.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: SizedBox(width: 20.w),
                              ),
                              TextSpan(
                                text: "($totalReviews نظر)",
                                style: context.labelSmall.copyWith(
                                  color: AppColors.tertiary,
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
            ),
            SizedBox(width: 10.w),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
