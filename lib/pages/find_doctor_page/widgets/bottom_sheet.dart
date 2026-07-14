part of '../find_doctor_page.dart';

void _showFilterBottomSheet(BuildContext context) {
  AppBottomSheet.show(
    context,
    title: 'فیلترها',
    titleStyle: context.headlineMedium.copyWith(
      color: AppColors.secondary,
    ),
    padding: 0,
    initialSnap: 1.0,
    backgroundColor: AppColors.blue9,
    children: [
      Consumer(
        builder: (context, ref, child) {
          final filters = ref.watch(findDoctorFilterProvider);
          final notifier = ref.watch(findDoctorFilterProvider.notifier);

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const _BottomSheetLabel(
                  label: 'دسته بندی',
                ),
                SizedBox(height: 20.h),
                _RadioTile<FindDoctorType>(
                  label: 'همه',
                  value: FindDoctorType.all,
                  groupValue: filters.type,
                  onChanged: (_) {
                    notifier.setType(FindDoctorType.all);
                  },
                ),
                SizedBox(height: 10.h),
                _RadioTile<FindDoctorType>(
                  label: 'دندانپزشک',
                  value: FindDoctorType.doctor,
                  groupValue: filters.type,
                  onChanged: (_) {
                    notifier.setType(FindDoctorType.doctor);
                  },
                ),
                SizedBox(height: 10.h),
                _RadioTile<FindDoctorType>(
                  label: 'کلینیک',
                  value: FindDoctorType.clinic,
                  groupValue: filters.type,
                  onChanged: (_) {
                    notifier.setType(FindDoctorType.clinic);
                  },
                ),
                Divider(
                  color: AppColors.grey2,
                  thickness: 1.w,
                  height: 40.h,
                ),
                const _BottomSheetLabel(
                  label: 'امتیاز',
                ),
                SizedBox(height: 20.h),
                _RadioTile<FindDoctorRate>(
                  label: 'همه',
                  value: FindDoctorRate.all,
                  groupValue: filters.rate,
                  onChanged: (_) {
                    notifier.setRate(FindDoctorRate.all);
                  },
                ),
                SizedBox(height: 10.h),
                _RadioTile<FindDoctorRate>(
                  label: '5 ستاره',
                  value: FindDoctorRate.fiveStar,
                  groupValue: filters.rate,
                  onChanged: (_) {
                    notifier.setRate(FindDoctorRate.fiveStar);
                  },
                ),
                SizedBox(height: 10.h),
                _RadioTile<FindDoctorRate>(
                  label: '4 ستاره',
                  value: FindDoctorRate.fourStar,
                  groupValue: filters.rate,
                  onChanged: (_) {
                    notifier.setRate(FindDoctorRate.fourStar);
                  },
                ),
                SizedBox(height: 10.h),
                _RadioTile<FindDoctorRate>(
                  label: '3 ستاره و کمتر',
                  value: FindDoctorRate.threeStarAndLess,
                  groupValue: filters.rate,
                  onChanged: (_) {
                    notifier.setRate(FindDoctorRate.threeStarAndLess);
                  },
                ),
                Divider(
                  color: AppColors.grey2,
                  thickness: 1.w,
                  height: 40.h,
                ),
                const _BottomSheetLabel(
                  label: 'تخصص',
                ),
                SizedBox(height: 20.h),
                _CheckTile(
                  label: 'همه',
                  value: filters.specialties.contains(FindDoctorSpecialty.all),
                  onChanged: (_) {
                    notifier.toggleSpecialty(FindDoctorSpecialty.all);
                  },
                ),
                SizedBox(height: 10.h),
                _CheckTile(
                  label: 'متخصص ارتودنسی',
                  value: filters.specialties
                      .contains(FindDoctorSpecialty.orthodontics),
                  onChanged: (_) {
                    notifier.toggleSpecialty(FindDoctorSpecialty.orthodontics);
                  },
                ),
                SizedBox(height: 10.h),
                _CheckTile(
                  label: 'متخصص درمان ریشه',
                  value: filters.specialties
                      .contains(FindDoctorSpecialty.rootTreatment),
                  onChanged: (_) {
                    notifier.toggleSpecialty(FindDoctorSpecialty.rootTreatment);
                  },
                ),
                SizedBox(height: 10.h),
                _CheckTile(
                  label: 'متخصص پروتزهای دندانی و ایمپلنت',
                  value: filters.specialties
                      .contains(FindDoctorSpecialty.prosthesisAndImplant),
                  onChanged: (_) {
                    notifier.toggleSpecialty(
                        FindDoctorSpecialty.prosthesisAndImplant);
                  },
                ),
                SizedBox(height: 10.h),
                _CheckTile(
                  label: 'متخصص رادیولوژی دهان فک و صورت',
                  value: filters.specialties
                      .contains(FindDoctorSpecialty.radiology),
                  onChanged: (_) {
                    notifier.toggleSpecialty(FindDoctorSpecialty.radiology);
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
    ],
    footer: Container(
      height: 95.h,
      color: AppColors.blue9,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              return Row(
                children: [
                  Expanded(
                    child: CustomButton.outlined(
                      label: 'حذف همه',
                      color: Colors.transparent,
                      labelColor: AppColors.blue14,
                      borderColor: AppColors.blue14,
                      onTap: () {
                        ref.watch(findDoctorFilterProvider.notifier).clear();
                        context.pop();
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomButton(
                      label: 'اعمال فیلترها',
                      color: AppColors.primary,
                      labelColor: AppColors.onPrimary,
                      onTap: () {},
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}

class _BottomSheetLabel extends StatelessWidget {
  const _BottomSheetLabel({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.labelMedium.copyWith(
        color: AppColors.blue14,
      ),
    );
  }
}

class _RadioTile<T> extends StatelessWidget {
  const _RadioTile({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(value),
      child: Container(
        height: 55.h,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColors.green1 : AppColors.grey2,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(
                  color: AppColors.blue14,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            CustomRadio<T>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              borderColor: isSelected ? AppColors.green1 : AppColors.grey2,
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckTile extends StatelessWidget {
  const _CheckTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(value),
      child: Container(
        height: 55.h,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: value ? AppColors.green1 : AppColors.grey2,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(
                  color: AppColors.blue14,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            CustomCheckbox(
              value: value,
              onChanged: onChanged,
              borderColor: value ? AppColors.green1 : AppColors.grey2,
            )
          ],
        ),
      ),
    );
  }
}
