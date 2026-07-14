part of '../find_doctor_page.dart';

class _Card extends ConsumerWidget {
  const _Card({
    this.isClinic = false,
    required this.id,
    required this.name,
    required this.rating,
    required this.phone,
    this.studyField,
    this.avatar,
  });

  final bool isClinic;
  final String id;
  final String name;
  final String? studyField;
  final double rating;
  final int phone;
  final String? avatar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (isClinic) {
          context.push(AppRoutes.clinic, extra: id);
        } else {
          context.push(AppRoutes.doctor, extra: id);
        }
      },
      child: Container(
        width: 140.w,
        height: isClinic ? 144.h : 166.h,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white10,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56.h,
              width: 56.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.blue13,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 2.w,
                ),
                image: DecorationImage(
                  image: customNetworkImageProvider(
                    url: avatar,
                    fallback: isClinic
                        ? 'assets/images/image2.png'
                        : 'assets/images/user2.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.labelSmall.copyWith(
                color: AppColors.onSecondary,
              ),
            ),
            if (!isClinic) ...[
              SizedBox(height: 10.h),
              Text(
                studyField ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelSmall.copyWith(
                  color: AppColors.onSecondary,
                  fontSize: 10.sp,
                ),
              ),
            ],
            SizedBox(height: 18.h),
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: rating.toString(),
                    style: context.labelSmall.copyWith(
                      color: AppColors.tertiary,
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
            )
          ],
        ),
      ),
    );
  }
}
