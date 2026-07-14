part of '../register_consult_page.dart';

class _Button extends HookConsumerWidget {
  const _Button({
    required this.phone,
    required this.otp,
    required this.loading,
    required this.scrollController,
  });

  final TextEditingController phone;
  final TextEditingController otp;
  final ValueNotifier<bool> loading;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerConsult = ref.watch(registerConsultProvider);
    final notifier = ref.watch(registerConsultProvider.notifier);
    final isValidPhone = useState(false);
    final isValidOtp = useState(false);
    useEffect(() {
      phone.addListener(() {
        isValidPhone.value = phone.text.trim().toEnglishDigit().isValidPhone;
      });
      otp.addListener(() {
        isValidOtp.value = otp.text.trim().toEnglishDigit().isValidOtp;
      });
      isValidPhone.addListener(() {
        if (isValidPhone.value) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      });
      isValidOtp.addListener(() {
        if (isValidOtp.value) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      });
      return null;
    }, []);
    return CustomButton(
      width: 152.w,
      color: AppColors.primary,
      loadingColor: AppColors.blue17,
      height: 43.h,
      label: registerConsult.otpSent ? 'تایید' : 'ارسال کد',
      labelColor: AppColors.onPrimary,
      isLoading: loading.value,
      onTap: (registerConsult.otpSent ? isValidOtp.value : isValidPhone.value)
          ? () async {
              loading.value = true;
              final number = phone.text.trim().toEnglishDigit();
              if (!registerConsult.otpSent) {
                final succeeded = await ref
                    .read(registerConsultProvider.notifier)
                    .sendOtp(phone: number);
                if (succeeded) {
                  notifier.setOtpStatus(true);
                  AppToast.showSuccess(
                    title: 'کد تائید به شماره $number فرستاده شد.',
                  );
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  });
                }
              } else {
                await notifier.register(
                  phone: number,
                  otp: otp.text.trim().toEnglishDigit(),
                );
              }
              loading.value = false;
            }
          : null,
    );
  }
}
