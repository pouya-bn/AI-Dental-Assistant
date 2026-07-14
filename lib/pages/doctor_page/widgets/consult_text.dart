part of '../doctor_page.dart';

class _ConsultChat extends StatelessWidget {
  const _ConsultChat({
    required this.doctorId,
  });

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'حداکثر زمان انتظار تا پاسخ‌گویی پزشک: 1 ساعت',
          style: context.labelSmall.copyWith(
            color: AppColors.onPrimary,
          ),
        ),
        SizedBox(height: 20.h),
        CustomButton(
          color: AppColors.background,
          labelColor: AppColors.green1,
          height: 40.h,
          width: double.maxFinite,
          label: 'شروع مشاوره متنی',
          onTap: () {
            _showConsultBottomSheet(
              context,
              doctorId: doctorId,
              isPhone: false,
            );
          },
        ),
      ],
    );
  }
}
