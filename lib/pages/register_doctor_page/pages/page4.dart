part of '../register_doctor_page.dart';

class _Page4 extends HookConsumerWidget {
  const _Page4({
    required this.gender,
  });

  final ValueNotifier<GenderModel?> gender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerDoctorNotifier = ref.watch(registerDoctorProvider.notifier);
    return ListView(
      primary: false,
      children: [
        const SearchField(),
        SizedBox(height: 20.h),
        const CustomLabel(
          color: AppColors.blue23,
          label: LabelModel(
            title: 'نتایج',
          ),
        ),
        SizedBox(height: 10.h),
        const _Result(
          title: 'لمینیت سرامیکی',
        ),
        SizedBox(height: 5.h),
        const _Result(
          title: 'لمینیت کامپوزیتی',
        ),
      ],
    );
  }
}

class _Result extends StatelessWidget {
  const _Result({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: context.bodyMedium.copyWith(
              color: AppColors.blue23,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          height: 30.h,
          width: 30.h,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.add,
              color: AppColors.blue23,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
