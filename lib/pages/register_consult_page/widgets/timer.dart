part of '../register_consult_page.dart';

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
          color: AppColors.blue17,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
