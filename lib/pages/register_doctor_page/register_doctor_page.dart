import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/add_button.dart';
import 'package:ava/common/widgets/address_input.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/option_tile.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/common/widgets/textfield.dart';
import 'package:ava/core/models/date_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/models/work_hour_model.dart';
import 'package:ava/core/providers/register_doctor_provider.dart';
import 'package:ava/core/utils/date_picker.dart';
import 'package:ava/core/utils/day_picker.dart';
import 'package:ava/core/utils/gender_picker.dart';
import 'package:ava/core/utils/time_picker.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

part 'pages/page1.dart';
part 'pages/page2.dart';
part 'pages/page3.dart';
part 'pages/page4.dart';

class RegisterDoctorPage extends HookConsumerWidget {
  const RegisterDoctorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();
    final page = useState(1);
    final notifier = ref.watch(registerDoctorProvider.notifier);
    final gender = useState<GenderModel?>(notifier.gender);
    final birthdate = useState<DateModel?>(null);
    final workHours = useState<List<WorkHourModel>>([const WorkHourModel()]);
    return CustomScaffold.variant(
      canPop: false,
      titleText: page.value == 1
          ? 'دندانپزشک گرامی\nبا تشکر از حضور شما در پلتفرم آوا\nلطفا جهت احراز هویت خود اطلاعات زیر را تکمیل کنید'
          : null,
      textAlign: TextAlign.center,
      appbarHeight: page.value == 1 ? 80.h : 10.h,
      maxLines: 3,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: FlutterStepIndicator(
                onChange: (int index) {},
                list: List.generate(4, (index) => index + 1),
                page: page.value - 1,
                height: 18.h,
                progressColor: AppColors.blue1,
                positiveColor: AppColors.blue17,
                negativeColor: AppColors.blue22,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomLabel(
            color: AppColors.blue14,
            label: LabelModel(
              icon: switch (page.value) {
                1 => 'assets/images/svg/call.svg',
                2 => 'assets/images/svg/location.svg',
                3 => 'assets/images/svg/card-tick.svg',
                4 => 'assets/images/svg/box.svg',
                _ => 'assets/images/svg/card-tick.svg',
              },
              title: switch (page.value) {
                1 => 'اطلاعات شخصی',
                2 => 'اطلاعات تکمیلی',
                3 => 'اطلاعات طبابت',
                4 => 'اطلاعات درمانی و خدماتی',
                _ => 'اطلاعات تکمیلی',
              },
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: PageView(
              reverse: true,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                page.value = index + 1;
              },
              children: [
                _Page1(
                  gender: gender,
                  birthdate: birthdate,
                ),
                _Page2(
                  workHours: workHours,
                ),
                _Page3(
                  gender: gender,
                ),
                _Page4(
                  gender: gender,
                ),
              ],
            ),
          ),
        ],
      ),
      footer: Container(
        color: AppColors.blue9,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                label: page.value == 4 ? 'پیش نمایش اطلاعات' : 'مرحله بعدی',
                height: 48.h,
                color: AppColors.blue17,
                labelColor: AppColors.onSecondary,
                onTap: () {
                  if (page.value < 4) {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {}
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomButton.outlined(
                label: page.value == 1 ? 'لغو' : 'مرحله قبلی',
                height: 48.h,
                color: AppColors.blue9,
                borderColor: AppColors.blue17,
                labelColor: AppColors.blue17,
                side: BorderSide(
                  color: AppColors.blue17,
                  width: 2.w,
                ),
                onTap: () {
                  if (page.value > 1) {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    context.pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
