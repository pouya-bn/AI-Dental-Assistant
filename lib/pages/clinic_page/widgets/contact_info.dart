part of '../clinic_page.dart';

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({
    required this.clinic,
  });

  final ClinicModel clinic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (clinic.hasPhoneNumber)
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
                clinic.phoneNumber!,
                style: context.labelSmall.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        if (clinic.hasOpenTime) ...[
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
                clinic.openTime!,
                style: context.labelSmall.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ],
        if (clinic.hasZipCode) ...[
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
                clinic.zipCode!,
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
