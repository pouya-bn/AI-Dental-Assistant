part of '../edit_user_page.dart';

class _Options extends HookConsumerWidget {
  const _Options({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.nationalCode,
    required this.studyField,
    required this.birthdate,
    required this.localAvatar,
    required this.remoteAvatar,
  });

  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController nationalCode;
  final TextEditingController studyField;
  final ValueNotifier<DateModel?> birthdate;
  final ValueNotifier<File?> localAvatar;
  final ValueNotifier<String?> remoteAvatar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(userProvider.notifier);
    final gender = useState<GenderModel?>(notifier.gender);
    final education = useState<EducationModel?>(notifier.education);
    final sicknesses = useState<List<UserSicknessModel>>(notifier.sicknesses);
    return ListView(
      primary: false,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      children: [
        GestureDetector(
          onTap: () async {
            final file = await pickImage();
            if (file != null) {
              localAvatar.value = file;
            }
          },
          child: Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50.h,
                  backgroundColor: AppColors.blue4,
                  backgroundImage: localAvatar.value != null
                      ? FileImage(localAvatar.value!)
                      : customNetworkImageProvider(
                          url: remoteAvatar.value,
                          fallback: 'assets/images/user.png',
                        ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.background,
                        width: 4.w,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.h),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: const CustomSvg(
                      'assets/images/svg/edit.svg',
                      color: AppColors.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        const CustomLabel(
          label: LabelModel(
            icon: 'assets/images/svg/profile-circle.svg',
            title: 'اطلاعات اصلی',
          ),
        ),
        SizedBox(height: 20.h),
        _EditTile(
          title: 'نام',
          hintText: 'نام',
          controller: firstName,
        ),
        SizedBox(height: 30.h),
        _EditTile(
          title: 'نام خانوادگی',
          hintText: 'نام خانوادگی',
          controller: lastName,
        ),
        SizedBox(height: 30.h),
        _EditTile(
          title: 'کد ملی',
          hintText: 'کد ملی',
          keyboardType: TextInputType.number,
          controller: nationalCode,
        ),
        SizedBox(height: 30.h),
        _EditTile(
          title: 'ایمیل',
          hintText: 'ایمیل',
          controller: email,
        ),
        CustomDivider(
          height: 60.h,
        ),
        const CustomLabel(
          label: LabelModel(
            icon: 'assets/images/svg/lifebuoy.svg',
            title: 'اطلاعات تکمیلی',
          ),
        ),
        SizedBox(height: 30.h),
        OptionTile(
          title: 'جنسیت',
          hintText: 'جنسیت',
          value: gender.value?.name,
          onTap: () async {
            final result = await showGenderPicker(context, ref);
            if (result != null) {
              gender.value = result;
            }
          },
        ),
        SizedBox(height: 30.h),
        OptionTile(
          title: 'تاریخ تولد',
          hintText: 'تاریخ تولد',
          value: birthdate.value?.jalaliString,
          onTap: () async {
            final result = await showCustomDatePicker(
              context,
              initialDate: birthdate.value,
            );
            if (result != null) {
              birthdate.value = result;
            }
          },
        ),
        SizedBox(height: 30.h),
        OptionTile(
          title: 'تحصیلات',
          hintText: 'تحصیلات',
          value: education.value?.name,
          onTap: () async {
            final result = await showEducationPicker(context, ref);
            if (result != null) {
              education.value = result;
            }
          },
        ),
        SizedBox(height: 30.h),
        _EditTile(
          title: 'تخصص',
          hintText: 'تخصص',
          controller: studyField,
        ),
        SizedBox(height: 30.h),
        const CustomLabel(
          color: AppColors.onSecondary,
          label: LabelModel(
            title: 'آدرس مطب',
          ),
        ),
        SizedBox(height: 10.h),
        AddressInput(
          address: notifier.address,
          onChanged: notifier.updateAddress,
        ),
        CustomDivider(
          height: 60.h,
        ),
        const CustomLabel(
          label: LabelModel(
            icon: 'assets/images/svg/note-2.svg',
            title: 'سوابق بیماری',
          ),
        ),
        SizedBox(height: 23.h),
        if (sicknesses.value.isEmpty)
          Text(
            'هیچ سابقه‌ای ثبت نشده است.',
            style: context.labelSmall.copyWith(
              color: AppColors.onSecondary,
            ),
          )
        else
          Wrap(
            spacing: 5.w,
            children: sicknesses.value
                .map(
                  (sickness) => Chip(
                    color: const WidgetStatePropertyAll(AppColors.blue9),
                    side: BorderSide.none,
                    label: Text(
                      sickness.sicknessName ?? 'نام بیماری',
                      style: context.labelMedium.copyWith(
                        color: AppColors.blue14,
                      ),
                    ),
                    deleteIcon: const CustomSvg(
                      'assets/images/svg/close.svg',
                      color: AppColors.blue14,
                    ),
                    onDeleted: () async {
                      final succeeded = await notifier.deleteUserSickness(
                        id: sickness.id,
                      );
                      if (succeeded) {
                        sicknesses.value = sicknesses.value
                            .where((element) => element.id != sickness.id)
                            .toList();
                      }
                    },
                  ),
                )
                .toList(),
          ),
        SizedBox(height: 23.h),
        CustomButton.outlined(
          height: 40.h,
          onTap: () async {
            final result = await showSicknessPicker(context);
            if (result != null) {
              if (sicknesses.value.any((e) => e.sicknessId == result.id)) {
                return;
              }
              final sickness = await notifier.createUserSickness(
                sicknessId: result.id,
              );
              if (sickness != null) {
                sicknesses.value = [
                  ...sicknesses.value,
                  sickness,
                ];
              }
            }
          },
          label: 'اضافه کردن',
          color: Colors.transparent,
          labelColor: AppColors.onSecondary,
          borderColor: AppColors.onSecondary,
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}

class _EditTile extends StatelessWidget {
  const _EditTile({
    required this.title,
    required this.hintText,
    required this.controller,
    this.keyboardType,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          color: AppColors.onSecondary,
          label: LabelModel(
            title: title,
          ),
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
