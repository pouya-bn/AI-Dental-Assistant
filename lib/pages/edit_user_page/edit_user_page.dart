import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/address_input.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/option_tile.dart';
import 'package:ava/common/widgets/textfield.dart';
import 'package:ava/core/models/date_model.dart';
import 'package:ava/core/models/education_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/models/sickness_model.dart';
import 'package:ava/core/models/user_model.dart';
import 'package:ava/core/providers/user_provider.dart';
import 'package:ava/core/utils/date_picker.dart';
import 'package:ava/core/utils/education_picker.dart';
import 'package:ava/core/utils/format.dart';
import 'package:ava/core/utils/gender_picker.dart';
import 'package:ava/core/utils/pickers.dart';
import 'package:ava/core/utils/sickness_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

part 'widgets/options.dart';

class EditUserPage extends HookConsumerWidget {
  const EditUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final notifier = ref.watch(userProvider.notifier);
    final firstName = useTextEditingController(text: self.firstName);
    final lastName = useTextEditingController(text: self.lastName);
    final username = useTextEditingController(text: self.username);
    final email = useTextEditingController(text: self.email);
    final nationalCode = useTextEditingController(
      text: self.nationalCode?.toString(),
    );
    final studyField = useTextEditingController(text: self.studyField);
    final birthdate = useState<DateModel?>(null);
    if (self.birthdate != null) {
      final gregorian = DateTime.parse(self.birthdate!);
      final jalali = Jalali.fromDateTime(gregorian);
      birthdate.value = DateModel.fromJalali(jalali);
    }
    final loading = useState(false);
    final localAvatar = useState<File?>(null);
    final remoteAvatar = useState<String?>(getStorageUrl(self.avatarUrl));
    return CustomScaffold(
      titleText: 'ویرایش اطلاعات کاربری',
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
              final succeeded = await notifier.editUser(
                editUser: EditUserModel(
                  firstName: firstName.text.trim(),
                  lastName: lastName.text.trim(),
                  email: email.text.trim(),
                  nationalCode: int.tryParse(nationalCode.text.trim()),
                  studyField: studyField.text.trim(),
                  gender: notifier.gender?.id,
                  education: notifier.education?.id,
                  birthdate: birthdate.value?.gregorianString,
                  provinceId: notifier.address?.province?.id,
                  cityId: notifier.address?.city?.id,
                  address: notifier.address?.address?.trim(),
                  number: notifier.address?.number,
                  unit: notifier.address?.unit,
                ),
                avatar: localAvatar.value,
              );
              if (succeeded) {
                AppToast.showSuccess(
                  title: 'تغییرات ذخیره شد',
                );
                if (context.mounted) {
                  context.pop();
                }
              } else {
                AppToast.showError(
                  title: 'خطا در ذخیره تغییرات',
                  description: 'لطفا دوباره تلاش کنید',
                );
              }
              loading.value = false;
            },
          )
      ],
      body: user.when(
        data: (_) {
          return _Options(
            firstName: firstName,
            lastName: lastName,
            username: username,
            email: email,
            nationalCode: nationalCode,
            studyField: studyField,
            birthdate: birthdate,
            localAvatar: localAvatar,
            remoteAvatar: remoteAvatar,
          );
        },
        loading: () => const Center(
          child: Loading(
            color: AppColors.onSecondary,
          ),
        ),
        error: (error, _) {
          logger.e(error);
          return const CustomError(
            color: AppColors.tertiary,
          );
        },
      ),
    );
  }
}
