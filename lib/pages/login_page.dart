import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/phone_field.dart';
import 'package:ava/core/providers/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final phone = useTextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_white.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 90.h),
                    Text(
                      'خوش آمدید!',
                      textAlign: TextAlign.start,
                      style: context.headlineMedium.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'لطفا شماره موبایلتان را وارد کنید تا بتوانیم با شما در ارتباط باشیم.',
                      textAlign: TextAlign.start,
                      style: context.bodySmall.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                    SizedBox(height: 27.h),
                    PhoneField(
                      phone: phone,
                    ),
                    SizedBox(height: 157.h),
                    _Button(
                      phone: phone,
                      loading: loading,
                    ),
                    SizedBox(height: 23.h),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: context.bodySmall.copyWith(
                          color: AppColors.secondary,
                        ),
                        children: [
                          const TextSpan(
                            text: 'با ثبت نام در اپلیکیشن آوا، ',
                          ),
                          TextSpan(
                            text: 'قوانین و شرایط',
                            style: context.bodySmall.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: Open terms and conditions
                              },
                          ),
                          const TextSpan(
                            text: ' را قبول می‌کنم.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.mediaQuery.viewInsets.bottom + 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends HookConsumerWidget {
  const _Button({
    required this.phone,
    required this.loading,
  });

  final TextEditingController phone;
  final ValueNotifier<bool> loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isValid = useState(false);
    useEffect(() {
      phone.addListener(() {
        isValid.value = phone.text.trim().toEnglishDigit().isValidPhone;
      });
      isValid.addListener(() {
        if (isValid.value) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      });
      return null;
    }, []);
    return CustomButton(
      width: double.maxFinite,
      color: AppColors.primary,
      loadingColor: AppColors.onPrimary,
      label: 'ادامه',
      labelColor: AppColors.onPrimary,
      isLoading: loading.value,
      disabledBgColor: AppColors.grey2,
      onTap: isValid.value
          ? () async {
              loading.value = true;
              final number = phone.text.trim().toEnglishDigit();
              final succeeded =
                  await ref.read(authProvider.notifier).sendOtp(phone: number);
              if (succeeded) {
                if (context.mounted) {
                  context.push(
                    AppRoutes.otp,
                    extra: number,
                  );
                }
              }
              loading.value = false;
            }
          : null,
    );
  }
}
