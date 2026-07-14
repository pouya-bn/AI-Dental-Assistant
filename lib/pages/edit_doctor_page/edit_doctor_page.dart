import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/option_tile.dart';
import 'package:ava/common/widgets/textfield.dart';
import 'package:ava/core/models/date_model.dart';
import 'package:ava/core/models/education_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/models/user_model.dart';
import 'package:ava/core/providers/user_provider.dart';
import 'package:ava/core/utils/date_picker.dart';
import 'package:ava/core/utils/education_picker.dart';
import 'package:ava/core/utils/format.dart';
import 'package:ava/core/utils/gender_picker.dart';
import 'package:ava/core/utils/pickers.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

part 'widgets/options.dart';

class EditDoctorPage extends HookConsumerWidget {
  const EditDoctorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
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
    final localAvatar = useState<File?>(null);
    final remoteAvatar = useState<String?>(getStorageUrl(self.avatarUrl));
    final addresses = useState([TextEditingController()]);
    return CustomScaffold(
      titleText: 'ویرایش اطلاعات کاربری',
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
            addresses: addresses,
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
