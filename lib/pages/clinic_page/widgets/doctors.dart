part of '../clinic_page.dart';

class _Doctors extends HookWidget {
  const _Doctors();

  static const _doctors = [
    {
      'image': 'assets/images/temp/doctor.png',
      'name': 'دکتر رضا ملا',
      'specialty': 'دندانپزشک متخصص پریودنتیست',
    },
    {
      'image': 'assets/images/temp/doctor_3.png',
      'name': 'دکتر زهره ملا',
      'specialty': 'دکترای حرفه‌ای دندانپزشکی',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _doctors.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final doctor = _doctors[index];
            return _DoctorTile(
              image: doctor['image'] as String,
              name: doctor['name'] as String,
              specialty: doctor['specialty'] as String,
            );
          },
        ),
      ],
    );
  }
}

class _DoctorTile extends StatelessWidget {
  const _DoctorTile({
    required this.image,
    required this.name,
    required this.specialty,
  });

  final String image;
  final String name;
  final String specialty;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50.h,
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.blue4,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: AppColors.onPrimary,
              width: 2.w,
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
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                specialty,
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
        SizedBox(width: 10.w),
        Icon(
          Icons.chevron_right_rounded,
          size: 16.sp,
          color: AppColors.onPrimary,
        ),
      ],
    );
  }
}
