import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/address.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/expertises.dart';
import 'package:ava/common/widgets/footer_button.dart';
import 'package:ava/common/widgets/licences.dart';
import 'package:ava/common/widgets/profile_media.dart';
import 'package:ava/common/widgets/profile_rating.dart';
import 'package:ava/common/widgets/profile_tabbar.dart';
import 'package:ava/common/widgets/radio_tile.dart';
import 'package:ava/common/widgets/section.dart';
import 'package:ava/common/widgets/sliver_sized_box.dart';
import 'package:ava/common/widgets/tabbar.dart';
import 'package:ava/common/widgets/textfield.dart';
import 'package:ava/core/models/doctor_model.dart';
import 'package:ava/core/models/item_model.dart';
import 'package:ava/core/providers/doctor_provider.dart';
import 'package:ava/core/utils/format.dart';
import 'package:ava/core/utils/pickers.dart';
import 'package:ava/core/utils/tabbar_view.dart';

part 'widgets/about_doctor.dart';
part 'widgets/consult_phone.dart';
part 'widgets/consult_text.dart';
part 'widgets/contact_info.dart';
part 'widgets/doctor_title.dart';

class DoctorPage extends HookConsumerWidget {
  const DoctorPage({
    super.key,
    required this.doctorId,
  });

  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoScrollController = useAutoScrollController();
    final doctor = ref.watch(doctorProvider(doctorId));
    return CustomScaffold(
      titleText: 'پروفایل',
      background: const Background2(),
      body: doctor.when(
        data: (doctor) {
          var tabsLength = 0;
          if (doctor.hasContactInfo) tabsLength++;
          if (doctor.hasAbout) tabsLength++;
          if (doctor.hasAddress) tabsLength++;
          if (doctor.hasPhoneConsultancy) tabsLength++;
          if (doctor.hasChatConsultancy) tabsLength++;
          if (doctor.hasLicenses) tabsLength++;
          if (doctor.hasExpertises) tabsLength++;
          final hasTabs = tabsLength > 0;
          final tabController = useTabController(
            initialLength: tabsLength,
          );
          return Column(
            children: [
              Expanded(
                child: CustomTabBarView<ItemModel>(
                  autoScrollController: autoScrollController,
                  tabController: tabController,
                  separatorBuilder: (context, index) {
                    return CustomDivider(margin: 20.w);
                  },
                  itemBuilder: (item, index) {
                    return CustomSection(
                      label: item.label,
                      child: item.child,
                    );
                  },
                  header: [
                    SliverSizedBox(height: 20.h),
                    ProfileMedia(
                      gallery: doctor.gallery,
                      fallback: 'assets/images/clinic.png',
                    ),
                    SliverSizedBox(height: 20.h),
                    _DoctorTitle(
                      doctor: doctor,
                    ),
                    SliverSizedBox(height: 20.h),
                    SliverDivider(margin: 20.w),
                    SliverSizedBox(height: 10.h),
                    ProfileRating(
                      commentCount: doctor.commentCount,
                      rate: doctor.rate,
                    ),
                    SliverSizedBox(height: 10.h),
                    if (hasTabs)
                      ProfileTabBar(
                        tabController: tabController,
                        tabs: [
                          if (doctor.hasContactInfo)
                            const CustomTab(title: 'اطلاعات تماس'),
                          if (doctor.hasAbout)
                            const CustomTab(title: 'درباره پزشک'),
                          if (doctor.hasAddress) const CustomTab(title: 'آدرس'),
                          if (doctor.hasPhoneConsultancy)
                            const CustomTab(title: 'مشاوره تلفنی'),
                          if (doctor.hasChatConsultancy)
                            const CustomTab(title: 'مشاوره متنی'),
                          if (doctor.hasLicenses)
                            const CustomTab(title: 'گواهی‌ها'),
                          if (doctor.hasExpertises)
                            const CustomTab(title: 'خدمات'),
                        ],
                      )
                    else
                      SliverDivider(margin: 20.w),
                  ],
                  body: [
                    if (doctor.hasContactInfo)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/call.svg',
                          title: 'اطلاعات تماس',
                        ),
                        child: _ContactInfo(
                          doctor: doctor,
                        ),
                      ),
                    if (doctor.hasAbout)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/document.svg',
                          title: 'درباره پزشک',
                        ),
                        child: _AboutDoctor(
                          doctor: doctor,
                        ),
                      ),
                    if (doctor.hasAddress)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/location.svg',
                          title: 'آدرس',
                        ),
                        child: Address(
                          address: doctor.address,
                          location: doctor.location,
                        ),
                      ),
                    if (doctor.hasPhoneConsultancy)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/call-calling.svg',
                          title: 'مشاوره تلفنی',
                        ),
                        child: _ConsultPhone(
                          doctorId: doctorId,
                        ),
                      ),
                    if (doctor.hasChatConsultancy)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/notification-status.svg',
                          title: 'مشاوره متنی',
                        ),
                        child: _ConsultChat(
                          doctorId: doctorId,
                        ),
                      ),
                    if (doctor.hasLicenses)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/card-tick.svg',
                          title: 'گواهی‌ها',
                        ),
                        child: Licences(
                          licenses: doctor.licenses,
                        ),
                      ),
                    if (doctor.hasExpertises)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/notification-status.svg',
                          title: 'خدمات',
                        ),
                        child: Expertises(
                          expertises: doctor.expertises,
                        ),
                      ),
                    if (!hasTabs)
                      ItemModel(
                        child: SizedBox(
                          height: 200.h,
                          child: const CustomEmpty(
                            color: AppColors.tertiary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const FooterButton(
                title: 'ارسال مدارک برای پزشک',
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Loading(
            color: AppColors.onSecondary,
          ),
        ),
        error: (error, _) => const CustomError(
          color: AppColors.tertiary,
        ),
      ),
    );
  }
}

void _showConsultBottomSheet(
  BuildContext context, {
  required String doctorId,
  required bool isPhone,
}) {
  AppBottomSheet.show(
    context,
    title: 'رزرو مشاوره ${isPhone ? 'تلفنی' : 'متنی'}',
    titleStyle: context.headlineMedium.copyWith(
      color: AppColors.secondary,
    ),
    padding: 0,
    initialSnap: 1.0,
    children: [
      Consumer(
        builder: (context, ref, child) {
          final notifier = ref.watch(doctorProvider(doctorId).notifier);
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'ارسال مدارک پزشکی',
                  style: context.labelMedium.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'لطفا شرح حال مختصری از خود برای آگاهی بیشتر پزشک را در قسمت زیر توضیح دهید',
                  style: context.labelSmall.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 150.h,
                  child: CustomTextField(
                    maxLines: 5,
                    initialValue: isPhone
                        ? notifier.consultPhone?.brief
                        : notifier.consultText?.brief,
                    onChanged: (value) {
                      if (context.mounted) {
                        if (isPhone) {
                          notifier.setConsultPhone(brief: value);
                        } else {
                          notifier.setConsultText(brief: value);
                        }
                      }
                    },
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    style: context.labelSmall.copyWith(
                      color: AppColors.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText:
                        'سن، جنسیت و خلاصه ای از موضوع و ساعات ترجیحی شما برای شروع مشاوره را بنویسید',
                    hintStyle: context.labelSmall.copyWith(
                      color: AppColors.grey3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'حداکثر 400 کاراکتر',
                  style: context.labelSmall.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton.outlined(
                  label: 'بارگذاری مدارک',
                  onTap: () async {
                    final file = await pickFile();
                    if (file != null) {
                      if (isPhone) {
                        notifier.setConsultPhone(document: file);
                      } else {
                        notifier.setConsultText(document: file);
                      }
                    }
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    ],
    footer: Container(
      height: 95.h,
      color: AppColors.blue9,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              return CustomButton(
                label: 'رزرو مشاوره',
                color: AppColors.primary,
                labelColor: AppColors.onPrimary,
                onTap: () {
                  if (context.mounted) {
                    ref
                        .watch(doctorProvider(doctorId).notifier)
                        .reserveConsult();
                    context.pop();
                  }
                },
              );
            },
          ),
        ),
      ),
    ),
  );
}
