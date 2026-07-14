part of '../find_doctor_page.dart';

class _Content extends ConsumerWidget {
  const _Content({
    required this.latLng,
  });

  final LatLng latLng;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foundDoctors = ref.watch(findDoctorProvider(latLng: latLng));
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GestureDetector(
            onTap: () {
              if (AppValues.chatIntroSeen) {
                context.push(AppRoutes.chat);
              } else {
                context.push(AppRoutes.chatIntro);
              }
            },
            child: Image.asset(
              'assets/images/home1.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        _Label(
          title: 'محبوبترین دندانپزشکان',
          onShowAll: () {},
        ),
        SizedBox(height: 24.h),
        SizedBox(
          height: 180.h,
          child: foundDoctors.when(
            data: (doctors) {
              if (doctors.isEmpty) {
                return const CustomEmpty();
              }
              return Align(
                alignment: Alignment.centerRight,
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return _Card(
                      id: doctor.id,
                      name: doctor.name,
                      studyField: doctor.studyField,
                      rating: 5.0,
                      phone: 12345678,
                      avatar: doctor.avatar,
                    );
                  },
                ),
              );
            },
            loading: () => const Center(
              child: Loading(color: Colors.white),
            ),
            error: (error, _) => const Center(
              child: CustomError(),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        _Label(
          title: 'محبوبترین کلینیک‌ها',
          onShowAll: () {},
        ),
        SizedBox(height: 24.h),
        SizedBox(
          height: 160.h,
          child: foundDoctors.when(
            data: (clinics) {
              if (clinics.isEmpty) {
                return const CustomEmpty();
              }
              return Align(
                alignment: Alignment.centerRight,
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: clinics.length,
                  itemBuilder: (context, index) {
                    final clinic = clinics[index];
                    return _Card(
                      isClinic: true,
                      id: clinic.id,
                      name: clinic.name,
                      rating: 5.0,
                      phone: 12345678,
                      avatar: clinic.avatar,
                    );
                  },
                ),
              );
            },
            loading: () => const Center(
              child: Loading(color: Colors.white),
            ),
            error: (error, _) => const Center(
              child: CustomError(),
            ),
          ),
        ),
        SizedBox(height: 60.h),
      ],
    );
  }
}
