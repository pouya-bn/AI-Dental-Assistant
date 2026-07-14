part of '../doctor_page.dart';

class _DoctorTitle extends HookWidget {
  const _DoctorTitle({
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final saved = useState(false);
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
                url: getStorageUrl(doctor.avatar),
                fallback: 'assets/images/user.png',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.headlineSmall.copyWith(
                      color: AppColors.onSecondary,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    doctor.studyField,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelSmall.copyWith(
                      color: AppColors.tertiary,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 32.h,
                  width: 32.h,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => saved.value = !saved.value,
                    icon: CustomSvg(
                      saved.value
                          ? 'assets/images/svg/archive_filled.svg'
                          : 'assets/images/svg/archive.svg',
                    ),
                    style: IconButton.styleFrom(
                      highlightColor: AppColors.highlight,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: doctor.status,
                        style: context.labelSmall.copyWith(
                          color: doctor.isOnline
                              ? AppColors.green1
                              : AppColors.background,
                          fontSize: 10.sp,
                        ),
                      ),
                      if (doctor.isOnline)
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Icon(
                              Icons.circle,
                              size: 8.sp,
                              color: AppColors.green1,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
