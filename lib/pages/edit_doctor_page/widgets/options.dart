part of '../edit_doctor_page.dart';

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
    required this.addresses,
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
  final ValueNotifier<List<TextEditingController>> addresses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final userNotifier = ref.watch(userProvider.notifier);
    final gender = useState<GenderModel?>(userNotifier.gender);
    final education = useState<EducationModel?>(userNotifier.education);
    return Column(
      children: [
        Expanded(
          child: ListView(
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
                              width: 2.0.w,
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
                  title: 'اطلاعات کاربری',
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
                title: 'شماره همراه (عدم نشان دادن در صفحه اصلی)',
                hintText: 'شماره همراه',
                keyboardType: TextInputType.number,
                controller: nationalCode,
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
                title: 'شماره نظام پزشکی',
                hintText: 'شماره نظام پزشکی',
                keyboardType: TextInputType.number,
                controller: nationalCode,
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
              CustomDivider(
                height: 60.h,
              ),
              const CustomLabel(
                label: LabelModel(
                  icon: 'assets/images/svg/call.svg',
                  title: 'اطلاعات تماس',
                ),
              ),
              SizedBox(height: 30.h),
              _EditTile(
                title: 'ایمیل',
                hintText: 'ایمیل',
                controller: email,
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
              StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _EditTile(
                        title: 'آدرس',
                        hintText: 'آدرس',
                        controller: addresses.value.first,
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              addresses.value.add(TextEditingController());
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.onSecondary,
                                size: 16.w,
                              ),
                              Text(
                                'اضافه کردن',
                                style: context.labelMedium.copyWith(
                                  color: AppColors.onSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      for (var i = 1; i < addresses.value.length; i++)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h),
                            _EditTile(
                              title: 'آدرس ${i + 1}',
                              hintText: 'آدرس ${i + 1}',
                              controller: addresses.value[i],
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    addresses.value.removeAt(i);
                                  });
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.close,
                                      color: AppColors.onSecondary,
                                      size: 16.w,
                                    ),
                                    Text(
                                      'حذف',
                                      style: context.labelMedium.copyWith(
                                        color: AppColors.onSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
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
              Text(
                'هیچ سابقه‌ای ثبت نشده است.',
                style: context.labelSmall.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
              SizedBox(height: 30.h),
              CustomButton.outlined(
                onTap: () {},
                label: 'اضافه کردن',
                color: Colors.transparent,
                labelColor: AppColors.onSecondary,
                borderColor: AppColors.onSecondary,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: CustomButton(
            label: 'ذخیره تغییرات',
            color: AppColors.green1,
            labelColor: Colors.white,
            isLoading: loading.value,
            onTap: () async {
              loading.value = true;
              final succeeded = await userNotifier.editUser(
                editUser: EditUserModel(
                  firstName: firstName.text.trim(),
                  lastName: lastName.text.trim(),
                  email: email.text.trim(),
                  nationalCode: int.tryParse(nationalCode.text.trim()),
                  studyField: studyField.text.trim(),
                  gender: gender.value?.id,
                  education: education.value?.id,
                  birthdate: birthdate.value?.gregorianString,
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
          ),
        ),
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
    this.trailing,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
