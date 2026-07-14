part of '../map_page.dart';

class _DoctorCard extends HookConsumerWidget {
  const _DoctorCard({
    required this.doctor,
  });

  final LocatedDoctorModel doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(mapProvider.notifier);
    // final pageController = usePageController();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 30.h,
        ),
        child: GestureDetector(
          onTap: () => context.push(
            AppRoutes.doctor,
            extra: doctor.id,
          ),
          child: Stack(
            children: [
              Container(
                height: 270.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.blue5,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: AppColors.blue4,
                            // child: PageView.builder(
                            //   controller: pageController,
                            //   itemCount: 5,
                            //   itemBuilder: (_, index) => Image.asset(
                            //     'assets/images/clinic.png',
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            child: CustomNetworkImage(
                              url: doctor.banner,
                              fit: BoxFit.cover,
                              fallback: 'assets/images/clinic.png',
                            ),
                          ),
                          // Positioned(
                          //   bottom: 10.h,
                          //   left: 0,
                          //   right: 0,
                          //   child: Align(
                          //     alignment: Alignment.bottomCenter,
                          //     child: CustomIndicator(
                          //       controller: pageController,
                          //       count: 5,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Container(
                              width: 64.h,
                              height: 64.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: AppColors.blue13,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: CustomNetworkImage(
                                url: doctor.avatar,
                                fallback: 'assets/images/user.png',
                                fallbackFit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          doctor.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.headlineSmall.copyWith(
                                            color: AppColors.onSecondary,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      const CustomSvg(
                                        'assets/images/svg/arrow-circle-left.svg',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  if (doctor.address != null)
                                    Text(
                                      doctor.address!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.labelSmall.copyWith(
                                        color: AppColors.onSecondary,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          doctor.studyField,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.labelSmall.copyWith(
                                            color: AppColors.tertiary,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: doctor.status,
                                              style:
                                                  context.labelSmall.copyWith(
                                                color: doctor.isOnline
                                                    ? AppColors.green1
                                                    : AppColors.background,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                            if (doctor.isOnline)
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: 5.w,
                                                  ),
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: 8.sp,
                                                    color: AppColors.green1,
                                                  ),
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
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.h,
                child: IconButton(
                  onPressed: () => notifier.hideDoctor(),
                  icon: const CustomSvg(
                    'assets/images/svg/close_circle.svg',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
