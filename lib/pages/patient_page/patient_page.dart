import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/address.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/expertises.dart';
import 'package:ava/common/widgets/licences.dart';
import 'package:ava/common/widgets/profile_media.dart';
import 'package:ava/common/widgets/profile_rating.dart';
import 'package:ava/common/widgets/profile_tabbar.dart';
import 'package:ava/common/widgets/section.dart';
import 'package:ava/common/widgets/sliver_sized_box.dart';
import 'package:ava/common/widgets/tabbar.dart';
import 'package:ava/core/models/doctor_model.dart';
import 'package:ava/core/models/item_model.dart';
import 'package:ava/core/providers/doctor_provider.dart';
import 'package:ava/core/utils/tabbar_view.dart';

part 'widgets/about_patient.dart';
part 'widgets/contact_info.dart';
part 'widgets/patient_title.dart';

class PatientPage extends HookConsumerWidget {
  const PatientPage({
    super.key,
    required this.patientId,
  });

  final String patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoScrollController = useAutoScrollController();
    final patient = ref.watch(doctorProvider(patientId));
    return CustomScaffold(
      titleText: 'پروفایل',
      background: const Background2(),
      body: patient.when(
        data: (patient) {
          var tabsLength = 0;
          if (patient.hasContactInfo) tabsLength++;
          if (patient.hasAbout) tabsLength++;
          if (patient.hasAddress) tabsLength++;
          if (patient.hasPhoneConsultancy) tabsLength++;
          if (patient.hasChatConsultancy) tabsLength++;
          if (patient.hasLicenses) tabsLength++;
          if (patient.hasExpertises) tabsLength++;
          final hasTabs = tabsLength > 0;
          final tabController = useTabController(
            initialLength: tabsLength,
          );
          return CustomTabBarView<ItemModel>(
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
                gallery: patient.gallery,
                fallback: 'assets/images/clinic.png',
              ),
              SliverSizedBox(height: 20.h),
              _DoctorTitle(
                doctor: patient,
              ),
              SliverSizedBox(height: 20.h),
              SliverDivider(margin: 20.w),
              SliverSizedBox(height: 10.h),
              ProfileRating(
                commentCount: patient.commentCount,
                rate: patient.rate,
              ),
              SliverSizedBox(height: 10.h),
              if (hasTabs)
                ProfileTabBar(
                  tabController: tabController,
                  tabs: [
                    if (patient.hasContactInfo)
                      const CustomTab(title: 'اطلاعات تماس'),
                    if (patient.hasAbout) const CustomTab(title: 'درباره پزشک'),
                    if (patient.hasAddress) const CustomTab(title: 'آدرس'),
                    if (patient.hasPhoneConsultancy)
                      const CustomTab(title: 'مشاوره تلفنی'),
                    if (patient.hasChatConsultancy)
                      const CustomTab(title: 'مشاوره متنی'),
                    if (patient.hasLicenses) const CustomTab(title: 'گواهی‌ها'),
                    if (patient.hasExpertises) const CustomTab(title: 'خدمات'),
                  ],
                )
              else
                SliverDivider(margin: 20.w),
            ],
            body: [
              if (patient.hasContactInfo)
                ItemModel(
                  label: const LabelModel(
                    icon: 'assets/images/svg/call.svg',
                    title: 'اطلاعات تماس',
                  ),
                  child: _ContactInfo(
                    doctor: patient,
                  ),
                ),
              if (patient.hasAbout)
                ItemModel(
                  label: const LabelModel(
                    icon: 'assets/images/svg/document.svg',
                    title: 'درباره پزشک',
                  ),
                  child: _AboutDoctor(
                    doctor: patient,
                  ),
                ),
              if (patient.hasAddress)
                ItemModel(
                  label: const LabelModel(
                    icon: 'assets/images/svg/location.svg',
                    title: 'آدرس',
                  ),
                  child: Address(
                    address: patient.address,
                    location: patient.location,
                  ),
                ),
              if (patient.hasLicenses)
                ItemModel(
                  label: const LabelModel(
                    icon: 'assets/images/svg/card-tick.svg',
                    title: 'گواهی‌ها',
                  ),
                  child: Licences(
                    licenses: patient.licenses,
                  ),
                ),
              if (patient.hasExpertises)
                ItemModel(
                  label: const LabelModel(
                    icon: 'assets/images/svg/notification-status.svg',
                    title: 'خدمات',
                  ),
                  child: Expertises(
                    expertises: patient.expertises,
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
