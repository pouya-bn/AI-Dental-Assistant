part of '../doctor_page.dart';

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (doctor.hasPhoneNumber)
          Row(
            children: [
              Text(
                'شماره تماس',
                style: context.labelSmall.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
              const Spacer(),
              Text(
                doctor.phoneNumber!,
                style: context.labelSmall.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        if (doctor.hasOpenTime) ...[
          SizedBox(height: 20.h),
          Row(
            children: [
              Text(
                'ساعت کاری',
                style: context.labelSmall.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
              const Spacer(),
              Text(
                doctor.openTime!,
                style: context.labelSmall.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ],
        if (doctor.hasZipCode) ...[
          SizedBox(height: 20.h),
          Row(
            children: [
              Text(
                'کدپستی',
                style: context.labelSmall.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
              const Spacer(),
              Text(
                doctor.zipCode!,
                style: context.labelSmall.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ]
      ],
    );
  }
}
