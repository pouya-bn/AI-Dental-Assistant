import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/checkbox.dart';
import 'package:ava/common/widgets/otp_input.dart';
import 'package:ava/common/widgets/phone_field.dart';
import 'package:ava/core/providers/register_consult_provider.dart';
import 'package:ava/core/utils/format.dart';
import 'package:flutter/gestures.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

part 'widgets/button.dart';
part 'widgets/check_tile.dart';
part 'widgets/description.dart';
part 'widgets/timer.dart';

class RegisterConsultPage extends HookConsumerWidget {
  const RegisterConsultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final registerConsult = ref.watch(registerConsultProvider);
    final notifier = ref.watch(registerConsultProvider.notifier);
    final loading = useState(false);
    final phone = useTextEditingController();
    final otp = useTextEditingController();
    return CustomScaffold.variant(
      titleText: 'درخواست فعالسازی مشاوره',
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: ListView(
        primary: false,
        controller: scrollController,
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
        ),
        children: [
          const _Description(),
          SizedBox(height: 20.h),
          _CheckTile(
            label: 'فعالسازی مشاوره متنی',
            value: registerConsult.text,
            onChanged: (_) {
              notifier.toggleText();
            },
          ),
          SizedBox(height: 10.h),
          _CheckTile(
            label: 'فعالسازی مشاوره تلفنی',
            value: registerConsult.phone,
            onChanged: (_) {
              notifier.togglePhone();
            },
          ),
          SizedBox(height: 10.h),
          _CheckTile(
            label: 'فعالسازی مشاوره حضوری',
            value: registerConsult.inPerson,
            onChanged: (_) {
              notifier.toggleInPerson();
            },
          ),
          SizedBox(height: 30.h),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              notifier.toggleTerms();
            },
            child: Row(
              children: [
                CustomCheckbox(
                  value: registerConsult.terms,
                  onChanged: (_) {
                    notifier.toggleTerms();
                  },
                  borderColor: AppColors.blue20,
                  fillColor: AppColors.blue20,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'قوانین و مقررات فوق را مطالعه و پذیرفته ام',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.blue20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (registerConsult.terms) ...[
            SizedBox(height: 20.h),
            Text(
              'جهت تایید درخواست فعال سازی مشاوره  شماره موبایل خود را وارد کنید',
              style: context.labelMedium.copyWith(
                color: AppColors.blue14,
              ),
            ),
            SizedBox(height: 20.h),
            const CustomLabel(
              color: AppColors.blue23,
              label: LabelModel(
                title: 'شماره موبایل*',
              ),
            ),
            SizedBox(height: 10.h),
            PhoneField(
              enabled: !registerConsult.otpSent && !loading.value,
              phone: phone,
            ),
            if (registerConsult.otpSent) ...[
              SizedBox(height: 30.h),
              const CustomLabel(
                color: AppColors.blue23,
                label: LabelModel(
                  title: 'کد تایید*',
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'کد تائید به شماره ${phone.text} فرستاده شد.',
                textAlign: TextAlign.start,
                style: context.bodySmall.copyWith(
                  color: AppColors.blue17,
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'شماره موبایل اشتباه است؟ ',
                      style: context.bodySmall.copyWith(
                        color: AppColors.blue17,
                      ),
                    ),
                    TextSpan(
                      text: 'ویرایش',
                      style: context.bodySmall.copyWith(
                        color: AppColors.primary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          loading.value = false;
                          phone.clear();
                          otp.clear();
                          notifier.setOtpStatus(false);
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              OtpInput(
                controller: otp,
                onCompleted: (_) async {
                  if (!otp.text.trim().toEnglishDigit().isValidOtp) return;

                  loading.value = true;
                  await ref.read(registerConsultProvider.notifier).register(
                        phone: phone.text,
                        otp: otp.text.trim().toEnglishDigit(),
                      );
                  loading.value = false;
                },
              ),
              SizedBox(height: 10.h),
              _Timer(
                onResend: () async {
                  final succeeded =
                      await ref.read(registerConsultProvider.notifier).sendOtp(
                            phone: phone.text,
                          );
                  if (succeeded) {
                    AppToast.showSuccess(
                      title: 'کد تائید به شماره ${phone.text} فرستاده شد.',
                    );
                  }
                },
              ),
            ],
            SizedBox(height: 30.h),
            Center(
              child: _Button(
                phone: phone,
                otp: otp,
                loading: loading,
                scrollController: scrollController,
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ],
      ),
    );
  }
}
