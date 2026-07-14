part of '../patient_page.dart';

class _AboutDoctor extends StatelessWidget {
  const _AboutDoctor({
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (doctor.hasMedicalLicenseNumber)
          Text(
            'شماره نظام پزشکی: ${doctor.medicalLicenseNumber!}',
            style: context.labelSmall.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        if (doctor.hasDescription) ...[
          SizedBox(height: 20.h),
          Text(
            doctor.description!,
            style: context.labelSmall.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ]
      ],
    );
  }
}
