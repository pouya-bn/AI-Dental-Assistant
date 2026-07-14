part of '../doctor_page.dart';

class _ConsultPhone extends HookWidget {
  const _ConsultPhone({
    required this.doctorId,
  });

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final selected = useState(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'شروع تماس بلافاصله بعد از انتخاب وقت',
          style: context.labelSmall.copyWith(
            color: AppColors.onPrimary,
          ),
        ),
        SizedBox(height: 20.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) => RadioTile<int>(
            value: index,
            groupValue: selected.value,
            onChanged: (int? value) {
              selected.value = value ?? 0;
            },
            title: 'شنبه 15 فروردین',
            decoration: BoxDecoration(
              color: AppColors.white20,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        CustomButton(
          color: AppColors.background,
          labelColor: AppColors.green1,
          height: 40.h,
          width: double.maxFinite,
          label: 'شروع مشاوره تلفنی',
          onTap: () {
            _showConsultBottomSheet(
              context,
              doctorId: doctorId,
              isPhone: true,
            );
          },
        ),
      ],
    );
  }
}
