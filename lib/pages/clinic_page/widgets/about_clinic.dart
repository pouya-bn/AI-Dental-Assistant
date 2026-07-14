part of '../clinic_page.dart';

class _AboutClinic extends StatelessWidget {
  const _AboutClinic({
    required this.clinic,
  });

  final ClinicModel clinic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (clinic.hasMedicalLicenseNumber)
          Text(
            'شماره نظام پزشکی: ${clinic.medicalLicenseNumber!}',
            style: context.labelSmall.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        if (clinic.hasDescription) ...[
          SizedBox(height: 20.h),
          Text(
            clinic.description!,
            style: context.labelSmall.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ]
      ],
    );
  }
}
