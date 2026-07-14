import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/core/models/date_model.dart';
import 'package:ava/core/models/exam_record_model.dart';
import 'package:ava/core/providers/exam_records_provider.dart';
import 'package:ava/core/utils/date_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ExamRecordsPage extends HookConsumerWidget {
  const ExamRecordsPage({super.key});

  static const _records = [
    ExamRecordModel(
      id: 'ABHSU98954KK',
      doctorName: 'دکتر رضا ملا',
      date: '2 خرداد 1403',
      time: '14:23',
      insuranceCode: '1234567891234567',
      medicine: 'ناپروکسن 500 MG',
      medicineUsage: 'هر 6 ساعت 1 عدد',
    ),
    ExamRecordModel(
      id: 'ABHSU98954KK',
      doctorName: 'دکتر رضا ملا',
      date: '2 خرداد 1403',
      time: '14:23',
      insuranceCode: '1234567891234567',
      medicine: 'ناپروکسن 500 MG',
      medicineUsage: 'هر 6 ساعت 1 عدد',
    ),
    ExamRecordModel(
      id: 'ABHSU98954KK',
      doctorName: 'دکتر رضا ملا',
      date: '2 خرداد 1403',
      time: '14:23',
      insuranceCode: '1234567891234567',
      medicine: 'ناپروکسن 500 MG',
      medicineUsage: 'هر 6 ساعت 1 عدد',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold.variant(
      titleText: 'سوابق معاینه',
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Stack(
            alignment: Alignment.center,
            children: [
              CustomSvg(
                'assets/images/svg/exam_header.svg',
                width: context.width,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    _records.length.toString(),
                    style: context.headlineLarge.copyWith(
                      color: AppColors.secondary,
                      fontSize: 40.sp,
                      height: 0.8,
                    ),
                  ),
                  Text(
                    'تعداد کلی معاینه‌ها',
                    style: context.labelSmall.copyWith(
                      color: AppColors.secondary,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SearchField(
            foregroundColor: AppColors.blue14,
            onFilterTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              _showFilterBottomSheet(context);
            },
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: _records.isEmpty
                ? const CustomEmpty()
                : ListView.separated(
                    itemCount: _records.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (_, index) => _Tile(
                      record: _records[index],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.record,
  });

  final ExamRecordModel record;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.blue11,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'کد معاینه: ${record.id}',
                  style: context.labelSmall.copyWith(
                    color: AppColors.blue14.withOpacity(0.5),
                    fontSize: 10.sp,
                  ),
                ),
              ),
              CustomButton(
                onTap: () {},
                size: Size.fromHeight(31.h),
                color: AppColors.blue14,
                label: 'معاینه تلفنی',
                labelStyle: context.labelSmall.copyWith(
                  color: AppColors.white,
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'پزشک معالج: ${record.doctorName}',
            style: context.labelSmall.copyWith(
              color: AppColors.blue14,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'تاریخ: ${record.date}   |   ${record.time}',
            style: context.labelSmall.copyWith(
              color: AppColors.blue14.withOpacity(0.5),
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'کد سامانه تامین اجتماعی: ${record.insuranceCode}',
            style: context.labelSmall.copyWith(
              color: AppColors.blue14.withOpacity(0.5),
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  record.medicine,
                  style: context.labelSmall.copyWith(
                    color: AppColors.blue14,
                  ),
                ),
              ),
              Text(
                record.medicineUsage,
                style: context.labelSmall.copyWith(
                  color: AppColors.blue14,
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

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
          final filters = ref.watch(examRecordsFilterProvider);
          final notifier = ref.watch(examRecordsFilterProvider.notifier);
          List<Widget> buildFilterChips() {
            List<Widget> chips = [];
            if (filters.sort != null) {
              chips.add(
                _FilterChip(
                  label: filters.sort!,
                  onRemove: () => notifier.removeSort(),
                ),
              );
            }
            if (filters.type != null) {
              chips.add(
                _FilterChip(
                  label: filters.type!,
                  onRemove: () => notifier.removeType(),
                ),
              );
            }
            if (filters.startDateJalali != null) {
              chips.add(
                _FilterChip(
                  label: 'از تاریخ ${filters.startDateJalali!}',
                  onRemove: notifier.removeStartDate,
                ),
              );
            }
            if (filters.endDateJalali != null) {
              chips.add(
                _FilterChip(
                  label: 'تا تاریخ ${filters.endDateJalali!}',
                  onRemove: notifier.removeEndDate,
                ),
              );
            }
            return chips;
          }

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10.w,
                  children: List<Widget>.generate(
                    buildFilterChips().length,
                    (int index) => buildFilterChips()[index],
                  ).toList(),
                ),
                SizedBox(height: 20.h),
                const _Label(
                  label: 'مرتب سازی بر اساس',
                ),
                SizedBox(height: 20.h),
                Wrap(
                  spacing: 10.w,
                  children: List<Widget>.generate(
                    notifier.sorts.length,
                    (int index) {
                      final value = notifier.sorts[index];
                      return _Chip(
                        value: value,
                        isSelected: filters.sort == value,
                        onSelected: (_) {
                          notifier.setSort(value);
                        },
                      );
                    },
                  ).toList(),
                ),
                Divider(
                  color: AppColors.blue11,
                  thickness: 1.w,
                  height: 40.h,
                ),
                const _Label(
                  label: 'نوع معاینه',
                ),
                SizedBox(height: 20.h),
                Wrap(
                  spacing: 10.w,
                  children: List<Widget>.generate(
                    notifier.types.length,
                    (int index) {
                      final value = notifier.types[index];
                      return _Chip(
                        value: value,
                        isSelected: filters.type == value,
                        onSelected: (_) {
                          notifier.setType(value);
                        },
                      );
                    },
                  ).toList(),
                ),
                Divider(
                  color: AppColors.blue11,
                  thickness: 1.w,
                  height: 40.h,
                ),
                const _Label(
                  label: 'مشاهده در بازه زمانی مشخص',
                ),
                SizedBox(height: 20.h),
                Wrap(
                  spacing: 10.w,
                  children: [
                    _Chip(
                      value: 'از تاریخ ${filters.startDateJalali ?? ''}',
                      isSelected: filters.startDateJalali != null,
                      onSelected: (_) async {
                        final initialDate = DateModel.fromJalali(
                          filters.startDateGregorian != null
                              ? Jalali.fromDateTime(
                                  DateTime.parse(filters.startDateGregorian!),
                                )
                              : Jalali.now(),
                        );
                        final result = await showCustomDatePicker(
                          context,
                          initialDate: initialDate,
                        );
                        if (result != null) {
                          notifier.setStartDate(result.jalali);
                        }
                      },
                    ),
                    _Chip(
                      value: 'تا تاریخ ${filters.endDateJalali ?? ''}',
                      isSelected: filters.endDateJalali != null,
                      onSelected: (_) async {
                        final initialDate = DateModel.fromJalali(
                          filters.endDateGregorian != null
                              ? Jalali.fromDateTime(
                                  DateTime.parse(filters.endDateGregorian!),
                                )
                              : Jalali.now(),
                        );
                        final result = await showCustomDatePicker(
                          context,
                          initialDate: initialDate,
                        );
                        if (result != null) {
                          notifier.setEndDate(result.jalali);
                        }
                      },
                    ),
                  ],
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
                        ref.watch(examRecordsFilterProvider.notifier).clear();
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

class _Label extends StatelessWidget {
  const _Label({
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

class _Chip extends StatelessWidget {
  const _Chip({
    required this.value,
    required this.isSelected,
    required this.onSelected,
  });

  final String value;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      color: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.blue14;
          }
          return AppColors.blue9;
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: AppColors.blue14,
          width: 1.w,
        ),
      ),
      label: Text(
        value,
        style: context.labelSmall.copyWith(
          color: isSelected ? AppColors.white : AppColors.blue14,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.onRemove,
  });

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Chip(
      color: WidgetStateProperty.all(AppColors.blue14),
      label: Text(
        label,
        style: context.labelSmall.copyWith(
          color: AppColors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: AppColors.blue14,
          width: 1.w,
        ),
      ),
      deleteIcon: const CustomSvg(
        'assets/images/svg/close_circle_outline.svg',
        color: AppColors.white,
      ),
      onDeleted: onRemove,
    );
  }
}
