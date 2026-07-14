part of '../register_doctor_page.dart';

class _Page3 extends HookConsumerWidget {
  const _Page3({
    required this.gender,
  });

  final ValueNotifier<GenderModel?> gender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerDoctorNotifier = ref.watch(registerDoctorProvider.notifier);
    return ListView(
      primary: false,
      children: [
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'پروانه طبابت*',
          ),
        ),
        SizedBox(height: 10.h),
        OptionTile(
          hintText: 'پروانه طبابت',
          value: gender.value?.name,
          onTap: () {},
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          trailing: const _Button(),
        ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'دانشنامه دکتری عمومی*',
          ),
        ),
        SizedBox(height: 10.h),
        OptionTile(
          hintText: 'دانشنامه دکتری عمومی',
          value: gender.value?.name,
          onTap: () {},
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          trailing: const _Button(),
        ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'دانشنامه تخصصی (اختیاری)',
          ),
        ),
        SizedBox(height: 10.h),
        OptionTile(
          hintText: 'دانشنامه تخصصی',
          value: gender.value?.name,
          onTap: () {},
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          trailing: const _Button(),
        ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'کارت نظام پزشکی*',
          ),
        ),
        SizedBox(height: 10.h),
        OptionTile(
          hintText: 'کارت نظام پزشکی',
          value: gender.value?.name,
          onTap: () {},
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          trailing: const _Button(),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.blue17,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'بارگذاری',
          style: context.bodyMedium.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
