import 'package:ava/common/values/imports.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pinput/pinput.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onClipboardFound,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  final void Function(String)? onSubmitted;
  final void Function(String)? onClipboardFound;

  @override
  Widget build(BuildContext context) {
    final otpTheme = PinTheme(
      width: 56.h,
      height: 59.h,
      constraints: const BoxConstraints(
        minWidth: double.maxFinite,
      ),
      textStyle: context.headlineMedium.copyWith(
        color: AppColors.onBackground,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.background,
        border: Border.all(
          color: AppColors.outlineVariant,
        ),
      ),
    );
    final decoration = otpTheme.decoration!;
    final textStyle = otpTheme.textStyle!;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 5,
        controller: controller,
        focusNode: focusNode,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        listenForMultipleSmsOnAndroid: true,
        validator: (String? value) {
          return (value ?? '').trim().toEnglishDigit().isValidOtp
              ? null
              : 'کد وارد شده اشتباه است. لطفا دوباره تلاش کنید.';
        },
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        separatorBuilder: (index) => SizedBox(width: 10.w),
        defaultPinTheme: otpTheme,
        focusedPinTheme: otpTheme.copyWith(
          decoration: decoration.copyWith(
            border: Border.all(color: AppColors.outline),
          ),
          textStyle: textStyle.copyWith(
            color: AppColors.primary,
          ),
        ),
        submittedPinTheme: otpTheme.copyWith(
          decoration: decoration.copyWith(
            border: Border.all(color: AppColors.outline),
          ),
        ),
        errorPinTheme: otpTheme.copyWith(
          decoration: decoration.copyWith(
            border: Border.all(color: AppColors.error),
          ),
        ),
        errorTextStyle: textStyle.copyWith(
          color: AppColors.error,
          fontSize: 12.sp,
        ),
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: AppColors.outline,
              margin: EdgeInsets.only(bottom: 9.h),
              width: 22.w,
              height: 1.h,
            ),
          ],
        ),
        onChanged: onChanged,
        onCompleted: onCompleted,
        onSubmitted: onSubmitted,
        onClipboardFound: onClipboardFound,
        errorBuilder: (errorText, pin) {
          if (errorText != null) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text(
                errorText,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: context.bodySmall.copyWith(
                  color: AppColors.error,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
