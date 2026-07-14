import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/switch.dart';
import 'package:ava/core/providers/settings_provider.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final loading = useState(false);
    return CustomScaffold(
      titleText: 'تنظیمات',
      actions: [
        if (loading.value)
          SizedBox(
            width: 40.w,
            child: Center(
              child: Loading(
                color: AppColors.onSecondary,
                radius: 10.sp,
              ),
            ),
          )
        else
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.check_rounded,
              color: AppColors.green2,
            ),
            onPressed: () async {
              loading.value = true;
              await ref.read(settingsProvider.notifier).confirmSettings();
              loading.value = false;
            },
          )
      ],
      body: settings.when(
        data: (settings) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            children: [
              const CustomLabel(
                label: LabelModel(
                  icon: 'assets/images/svg/call-calling2.svg',
                  title: 'امنیت',
                ),
              ),
              SizedBox(height: 10.h),
              _OptionTile2(
                title: 'تماس امن',
                initialValue: settings.safeCall,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(safeCall: value),
                      );
                },
              ),
              CustomDivider(
                height: 40.h,
              ),
              const CustomLabel(
                label: LabelModel(
                  icon: 'assets/images/svg/information.svg',
                  title: 'پیام رسانی',
                ),
              ),
              SizedBox(height: 10.h),
              _OptionTile2(
                title: 'ایمیل خبرنامه',
                initialValue: settings.rssEmail,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(rssEmail: value),
                      );
                },
              ),
              _OptionTile2(
                title: 'ایمیل اطلاعات درمان',
                initialValue: settings.treatmentEmail,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(treatmentEmail: value),
                      );
                },
              ),
              _OptionTile2(
                title: 'پیامک اطلاعات درمان',
                initialValue: false,
                onChanged: (_) {},
              ),
              CustomDivider(
                height: 40.h,
              ),
              const CustomLabel(
                label: LabelModel(
                  icon: 'assets/images/svg/notification-bing.svg',
                  title: 'اعلانات',
                ),
              ),
              SizedBox(height: 20.h),
              _OptionTile(
                title: 'دریافت نوبت دندانپزشک',
                description: 'یادآوری نوبت دندانپزشکی دریافت شده با اپلیکیشن',
                initialValue: settings.appointmentNotice,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(appointmentNotice: value),
                      );
                },
              ),
              SizedBox(height: 10.h),
              _OptionTile(
                title: 'بهداشت دهان و دندان',
                description: 'اعلام نکات جدید آموزشی و درمانی در بخش آموزش',
                initialValue: settings.newsNotice,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(newsNotice: value),
                      );
                },
              ),
              SizedBox(height: 10.h),
              _OptionTile(
                title: 'تقویم',
                description: 'یادآوری نکات جایگذاری شده در تقویم در تاریخ مشخص',
                initialValue: settings.calendarNotice,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(calendarNotice: value),
                      );
                },
              ),
              CustomDivider(
                height: 50.h,
              ),
              const CustomLabel(
                label: LabelModel(
                  icon: 'assets/images/svg/lifebuoy.svg',
                  title: 'دسترسی پذیری',
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'با فعال کردن گزینه متناسب با شرایطتان می‌توانیم تجربه ‌بهتری از درمان برای شما ایجاد کنیم.',
                style: context.labelSmall.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
              SizedBox(height: 20.h),
              _OptionTile(
                title: 'از ویلچر استفاده می‌کنم',
                description: 'معلول حرکتی',
                initialValue: settings.useWheelChair,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(useWheelChair: value),
                      );
                },
              ),
              SizedBox(height: 10.h),
              _OptionTile(
                title: 'ناشنوا یا کم شنوا هستم',
                description: 'ناشنوایی یا کم‌شنوایی',
                initialValue: settings.isDeaf,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(isDeaf: value),
                      );
                },
              ),
              SizedBox(height: 10.h),
              _OptionTile(
                title: 'نابینا یا کم بینا هستم',
                description: 'نابینایی یا کم بینایی',
                initialValue: settings.isBlind,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).updateSettings(
                        settings.copyWith(isBlind: value),
                      );
                },
              ),
              SizedBox(height: 30.h),
            ],
          );
        },
        loading: () => const Center(
          child: Loading(
            color: AppColors.onSecondary,
          ),
        ),
        error: (error, _) => const Center(
          child: CustomError(
            color: AppColors.tertiary,
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends HookWidget {
  const _OptionTile({
    required this.title,
    required this.description,
    required this.initialValue,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final isSwitched = useState(initialValue);
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 18.h),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: AppColors.blue15,
            width: 1.w,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.labelMedium.copyWith(
                    color: AppColors.tertiary,
                  ),
                ),
              ),
              CustomSwitch(
                isSwitched: isSwitched.value,
                onChanged: (value) {
                  isSwitched.value = value;
                  onChanged(value);
                },
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            style: context.labelSmall.copyWith(
              color: AppColors.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile2 extends HookWidget {
  const _OptionTile2({
    required this.title,
    required this.initialValue,
    required this.onChanged,
  });

  final String title;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final isSwitched = useState(initialValue);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.labelSmall.copyWith(
                    color: AppColors.onSecondary,
                  ),
                ),
              ),
              CustomSwitch(
                isSwitched: isSwitched.value,
                onChanged: (value) {
                  isSwitched.value = value;
                  onChanged(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
