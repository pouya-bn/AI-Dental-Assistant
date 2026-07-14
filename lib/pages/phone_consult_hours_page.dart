import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/option_tile.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/utils/gender_picker.dart';
import 'package:ava/core/utils/time_picker.dart';

class PhoneConsultHoursPage extends HookConsumerWidget {
  const PhoneConsultHoursPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = useState(0);
    final isAddingTime = useState(false);
    final gender = useState<GenderModel?>(null);
    return CustomScaffold.variant(
      titleText: 'ساعت های مشاوره تلفنی',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                const Expanded(
                  child: CustomLabel(
                    color: AppColors.blue20,
                    label: LabelModel(
                      title: 'تعریف وقت جدید',
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      if (!isAddingTime.value) {
                        isAddingTime.value = true;
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      backgroundColor: Colors.transparent,
                      side: BorderSide(
                        color: AppColors.blue20,
                        width: 1.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    icon: CustomSvg(
                      'assets/images/svg/add.svg',
                      color: AppColors.blue20,
                      height: 14.h,
                      width: 14.h,
                    ),
                    label: Text(
                      'اضافه کردن',
                      style: context.labelSmall.copyWith(
                        color: AppColors.blue20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomDivider(
            height: 40.h,
            color: AppColors.grey2,
            margin: 20.w,
          ),
          CustomLabel(
            color: AppColors.blue20,
            margin: 20.w,
            label: const LabelModel(
              title: 'وقت های تعریف شده فعال',
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 72.h,
            child: ListView.separated(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _TimeCard(
                    day: 'همه',
                    isActive: activeIndex.value == 0,
                    onTap: () {
                      activeIndex.value = 0;
                    },
                  );
                }
                return _TimeCard(
                  day: 'شنبه',
                  date: '03/03/03',
                  isActive: activeIndex.value == index,
                  onTap: () {
                    activeIndex.value = index;
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          if (isAddingTime.value) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: OptionTile(
                      hintText: 'روز*',
                      hintStyle: context.labelMedium.copyWith(
                        color: AppColors.blue20,
                      ),
                      titleSpacing: 8.h,
                      color: Colors.transparent,
                      borderColor: AppColors.blue20,
                      titleStyle: context.labelMedium.copyWith(
                        color: AppColors.blue20,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.blue20,
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
                      hintText: 'ساعت*',
                      titleSpacing: 8.h,
                      hintStyle: context.labelMedium.copyWith(
                        color: AppColors.blue20,
                      ),
                      color: Colors.transparent,
                      borderColor: AppColors.blue20,
                      titleStyle: context.labelMedium.copyWith(
                        color: AppColors.blue20,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.blue20,
                      ),
                      value: gender.value?.name,
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final result = await showCustomTimeRangePicker(
                          context,
                          maxDuration: const Duration(minutes: 15),
                        );
                        if (result != null) {
                          logger(result.toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
          Expanded(
            child: ListView.separated(
              primary: false,
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: 7,
              itemBuilder: (context, index) {
                return _TimeTile(
                  day: 'شنبه',
                  date: '03/03/03',
                  time: '09:15 - 09:00',
                  onRemove: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeCard extends HookWidget {
  const _TimeCard({
    required this.day,
    this.date,
    required this.isActive,
    required this.onTap,
  });

  final String day;
  final String? date;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 84.w,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.green3 : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.blue20,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  day,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.labelSmall.copyWith(
                    color: isActive ? AppColors.white : AppColors.blue20,
                  ),
                ),
              ),
              if (date != null) ...[
                SizedBox(height: 2.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    date!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelSmall.copyWith(
                      color: isActive ? AppColors.white : AppColors.blue20,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeTile extends HookWidget {
  const _TimeTile({
    required this.day,
    required this.date,
    required this.time,
    required this.onRemove,
  });

  final String day;
  final String date;
  final String time;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.blue20,
          width: 1.w,
        ),
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(
              height: 30.h,
              width: 30.h,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.close,
                  color: AppColors.red2,
                ),
                onPressed: onRemove,
              ),
            ),
            SizedBox(width: 5.w),
            Text(
              day,
              style: context.bodyMedium.copyWith(
                color: AppColors.blue20,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              date,
              style: context.bodyMedium.copyWith(
                color: AppColors.blue20,
              ),
            ),
            SizedBox(width: 10.h),
            const Spacer(),
            SizedBox(width: 10.h),
            Text(
              time,
              style: context.bodyMedium.copyWith(
                color: AppColors.blue20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
