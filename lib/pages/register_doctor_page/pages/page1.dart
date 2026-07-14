part of '../register_doctor_page.dart';

class _Page1 extends HookConsumerWidget {
  const _Page1({
    required this.gender,
    required this.birthdate,
  });

  final ValueNotifier<GenderModel?> gender;
  final ValueNotifier<DateModel?> birthdate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      primary: false,
      children: [
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'نام و نام خانوادگی*',
          ),
        ),
        SizedBox(height: 10.h),
        const CustomTextField(
          hintText: 'نام و نام خانوادگی',
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: OptionTile(
                title: 'جنسیت*',
                hintText: 'جنسیت',
                titleSpacing: 8.h,
                titleStyle: context.labelMedium.copyWith(
                  color: AppColors.blue14,
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.blue14,
                ),
                value: gender.value?.name,
                onTap: () async {
                  final result = await showGenderPicker(context, ref);
                  if (result != null) {
                    gender.value = result;
                  }
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: OptionTile(
                title: 'تاریخ تولد*',
                hintText: 'روز/ماه/سال',
                titleSpacing: 8.h,
                titleStyle: context.labelMedium.copyWith(
                  color: AppColors.blue14,
                ),
                trailing: const CustomSvg(
                  'assets/images/svg/calendar.svg',
                ),
                value: birthdate.value?.jalaliString,
                onTap: () async {
                  final result = await showCustomDatePicker(
                    context,
                    initialDate: birthdate.value,
                  );
                  if (result != null) {
                    birthdate.value = result;
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'شماره تماس*',
          ),
        ),
        SizedBox(height: 10.h),
        const CustomTextField(
          hintText: 'شماره تماس',
        ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'شماره نظام پزشکی*',
          ),
        ),
        SizedBox(height: 10.h),
        const CustomTextField(
          hintText: 'شماره نظام پزشکی',
        ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'درباره من*',
          ),
        ),
        SizedBox(height: 10.h),
        const CustomTextField(
          hintText: 'درباره من',
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
