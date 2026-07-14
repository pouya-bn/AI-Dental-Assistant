import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/radio_tile.dart';
import 'package:ava/core/providers/basic_provider.dart';

enum AccountType { doctor, clinic }

class SwitchAccountPage extends HookConsumerWidget {
  const SwitchAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final selected = useState<AccountType>(AccountType.doctor);
    return CustomScaffold(
      hasDivider: false,
      background: const Background2(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomSvg(
              'assets/images/svg/ava-logo.svg',
            ),
            SizedBox(height: 63.h),
            Text(
              'نوع کاربری خود را انتخاب کنید',
              style: context.bodyMedium.copyWith(
                color: AppColors.onSecondary,
              ),
            ),
            SizedBox(height: 20.h),
            RadioTile<AccountType>(
              value: AccountType.doctor,
              groupValue: selected.value,
              onChanged: (AccountType? value) {
                if (value != null) {
                  selected.value = value;
                }
              },
              height: 45.h,
              title: 'دندانپزشک',
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.outlineVariant,
                  width: 1.w,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            RadioTile<AccountType>(
              value: AccountType.clinic,
              groupValue: selected.value,
              onChanged: (AccountType? value) {
                if (value != null) {
                  selected.value = value;
                }
              },
              height: 45.h,
              title: 'کلینیک دندانپزشکی',
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.outlineVariant,
                  width: 1.w,
                ),
              ),
            ),
            SizedBox(height: 63.h),
            CustomButton(
              label: 'شروع',
              labelColor: AppColors.onSecondary,
              color: AppColors.blue17,
              isLoading: loading.value,
              loadingColor: AppColors.onSecondary,
              disabledBgColor: AppColors.blue17,
              onTap: () async {
                loading.value = true;
                await ref.watch(basicProvider.future).then((_) {
                  if (context.mounted) {
                    if (selected.value == AccountType.doctor) {
                      context.push(AppRoutes.registerDoctor);
                    } else {
                      // context.push(AppRoutes.registerClinic);
                    }
                  }
                }).catchError((e) {
                  logger.e(e);
                  AppToast.showError(
                    title: 'خطا در بارگذاری اطلاعات',
                  );
                });
                loading.value = false;
              },
            ),
          ],
        ),
      ),
    );
  }
}
