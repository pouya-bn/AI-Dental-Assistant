part of '../clinic_page.dart';

class _ClinicTitle extends HookWidget {
  const _ClinicTitle({
    required this.clinic,
  });

  final ClinicModel clinic;

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
                url: clinic.avatar,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinic.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.headlineSmall.copyWith(
                      color: AppColors.onSecondary,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    clinic.studyField,
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
          ],
        ),
      ),
    );
  }
}
