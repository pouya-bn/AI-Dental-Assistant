import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/otp_input.dart';
import 'package:ava/core/providers/auth_provider.dart';
import 'package:ava/core/utils/format.dart';
import 'package:flutter/gestures.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OtpPage extends HookConsumerWidget {
  const OtpPage({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final otp = useTextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background_white.jpg',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: ListView(
              primary: false,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              children: [
                SizedBox(height: 90.h),
                Text(
                  'کد تائید را وارد کنید',
                  textAlign: TextAlign.start,
                  style: context.headlineMedium.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'کد تائید به شماره $phone فرستاده شد.',
                  textAlign: TextAlign.start,
                  style: context.bodySmall.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(height: 30.h),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'شماره موبایل اشتباه است؟ ',
                        style: context.bodySmall.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      TextSpan(
                        text: 'ویرایش',
                        style: context.bodySmall.copyWith(
                          color: AppColors.primary,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = context.pop,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                OtpInput(
                  controller: otp,
                  onCompleted: (_) async {
                    if (!otp.text.trim().toEnglishDigit().isValidOtp) return;

                    loading.value = true;
                    await ref.read(authProvider.notifier).login(
                          phone: phone,
                          otp: otp.text.trim().toEnglishDigit(),
                        );
                    loading.value = false;
                  },
                ),
                SizedBox(height: 70.h),
                if (loading.value)
                  const Loading()
                else
                  _Timer(
                    onResend: () async {
                      final succeeded =
                          await ref.read(authProvider.notifier).sendOtp(
                                phone: phone,
                              );
                      if (succeeded) {
                        AppToast.showSuccess(
                          title: 'کد تائید به شماره $phone فرستاده شد.',
                        );
                      }
                    },
                  ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Timer extends HookWidget {
  const _Timer({
    required this.onResend,
  });

  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final timer = useState(AppValues.otpResendWait);
    useInterval(
      const Duration(seconds: 1),
      () {
        if (timer.value > 0) {
          timer.value--;
        }
      },
    );

    if (timer.value == 0) {
      return GestureDetector(
        onTap: () {
          timer.value = AppValues.otpResendWait;
          onResend();
        },
        child: Text(
          'ارسال دوباره کد با پیامک',
          style: context.bodySmall.copyWith(
            color: AppColors.primary,
          ),
        ),
      );
    }

    if (timer.value > 0) {
      return Text(
        'ارسال دوباره کد تائید تا ${formatMinuteSecond(timer.value)}',
        style: context.bodySmall.copyWith(
          color: AppColors.secondary,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
