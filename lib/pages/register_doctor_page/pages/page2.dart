part of '../register_doctor_page.dart';

class _Page2 extends HookConsumerWidget {
  const _Page2({
    required this.workHours,
  });

  final ValueNotifier<List<WorkHourModel>> workHours;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerDoctorProvider.notifier);
    return ListView(
      primary: false,
      children: [
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'آدرس مطب*',
          ),
        ),
        SizedBox(height: 10.h),
        AddressInput(
          address: notifier.address,
          onChanged: notifier.updateAddress,
        ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'کدپستی مطب*',
          ),
        ),
        SizedBox(height: 10.h),
        const CustomTextField(
          hintText: 'کدپستی مطب',
        ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'شماره تماس مطب*',
          ),
        ),
        SizedBox(height: 10.h),
        const CustomTextField(
          hintText: 'شماره تماس مطب',
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            const Expanded(
              child: CustomLabel(
                color: AppColors.blue14,
                label: LabelModel(
                  title: 'ساعات کاری مطب*',
                ),
              ),
            ),
            AddButton(
              onTap: () {
                if (workHours.value.length >= 7) {
                  AppToast.showInfo(
                    title: 'حداکثر تعداد ساعات کاری 7 روزه است',
                  );
                  return;
                }
                if (workHours.value.last.day == null ||
                    workHours.value.last.timeRange == null) {
                  AppToast.showInfo(
                    title: 'لطفاً ابتدا فیلدهای روز و ساعت را پر کنید',
                  );
                  return;
                }
                workHours.value = [
                  ...workHours.value,
                  const WorkHourModel(),
                ];
              },
            ),
          ],
        ),
        for (var i = 0; i < workHours.value.length; i++)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              _WorkHour(
                workHour: workHours.value[i],
                onSubmit: (workHour) {
                  workHours.value = [
                    ...workHours.value.sublist(0, i),
                    workHour,
                    ...workHours.value.sublist(i + 1),
                  ];
                },
              ),
            ],
          ),
        SizedBox(height: 16.h),
        const CustomLabel(
          color: AppColors.blue14,
          label: LabelModel(
            title: 'کلینیک',
          ),
        ),
        SizedBox(height: 10.h),
        const CustomTextField(
          hintText: 'کلینیک',
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

class _WorkHour extends HookConsumerWidget {
  const _WorkHour({
    required this.workHour,
    required this.onSubmit,
  });

  final WorkHourModel workHour;
  final ValueChanged<WorkHourModel> onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: OptionTile(
            hintText: 'روز*',
            titleSpacing: 8.h,
            titleStyle: context.labelMedium.copyWith(
              color: AppColors.blue14,
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.blue14,
            ),
            value: workHour.day?.name,
            onTap: () async {
              final result = await showDayPicker(context, ref);
              if (result != null) {
                onSubmit(
                  workHour.copyWith(
                    day: result,
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: OptionTile(
            enabled: workHour.day != null,
            hintText: 'ساعت کاری*',
            titleSpacing: 8.h,
            titleStyle: context.labelMedium.copyWith(
              color: AppColors.blue14,
            ),
            trailing: Icon(
              Icons.access_time_rounded,
              color: workHour.day != null
                  ? AppColors.blue14
                  : AppColors.outlineVariant,
            ),
            value: workHour.timeRange,
            onTap: () async {
              final result = await showCustomTimeRangePicker(context);
              if (result != null && context.mounted) {
                onSubmit(
                  workHour.copyWith(
                    startTime: result.startTime.persianFormat(context),
                    endTime: result.endTime.persianFormat(context),
                  ),
                );
              }
            },
            onDisabledTap: () {
              AppToast.showInfo(
                title: 'لطفاً ابتدا روز را انتخاب کنید',
              );
            },
          ),
        ),
      ],
    );
  }
}
