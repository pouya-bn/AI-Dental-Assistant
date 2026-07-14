import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/address.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/expertises.dart';
import 'package:ava/common/widgets/footer_button.dart';
import 'package:ava/common/widgets/licences.dart';
import 'package:ava/common/widgets/profile_media.dart';
import 'package:ava/common/widgets/profile_rating.dart';
import 'package:ava/common/widgets/profile_tabbar.dart';
import 'package:ava/common/widgets/section.dart';
import 'package:ava/common/widgets/sliver_sized_box.dart';
import 'package:ava/common/widgets/tabbar.dart';
import 'package:ava/core/models/clinic_model.dart';
import 'package:ava/core/models/item_model.dart';
import 'package:ava/core/providers/clinic_provider.dart';
import 'package:ava/core/utils/tabbar_view.dart';

part 'widgets/about_clinic.dart';
part 'widgets/clinic_title.dart';
part 'widgets/contact_info.dart';
part 'widgets/doctors.dart';

class ClinicPage extends HookConsumerWidget {
  const ClinicPage({
    super.key,
    required this.clinicId,
  });

  final String clinicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoScrollController = useAutoScrollController();
    final clinic = ref.watch(clinicProvider(clinicId));
    return CustomScaffold(
      titleText: 'پروفایل',
      background: const Background2(),
      body: clinic.when(
        data: (clinic) {
          var tabsLength = 0;
          if (clinic.hasContactInfo) tabsLength++;
          if (clinic.hasAbout) tabsLength++;
          if (clinic.hasAddress) tabsLength++;
          if (clinic.hasPhoneConsultancy) tabsLength++;
          if (clinic.hasChatConsultancy) tabsLength++;
          if (clinic.hasLicenses) tabsLength++;
          if (clinic.hasExpertises) tabsLength++;
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
                      gallery: clinic.gallery,
                      fallback: 'assets/images/clinic.png',
                    ),
                    SliverSizedBox(height: 20.h),
                    _ClinicTitle(
                      clinic: clinic,
                    ),
                    SliverSizedBox(height: 20.h),
                    SliverDivider(margin: 20.w),
                    SliverSizedBox(height: 10.h),
                    ProfileRating(
                      commentCount: clinic.commentCount,
                      rate: clinic.rate,
                    ),
                    SliverSizedBox(height: 10.h),
                    if (hasTabs)
                      ProfileTabBar(
                        tabController: tabController,
                        tabs: [
                          if (clinic.hasContactInfo)
                            const CustomTab(title: 'اطلاعات تماس'),
                          if (clinic.hasAbout)
                            const CustomTab(title: 'درباره کلینیک'),
                          if (clinic.hasAddress) const CustomTab(title: 'آدرس'),
                          if (clinic.hasPhoneConsultancy)
                            const CustomTab(title: 'مشاوره تلفنی'),
                          if (clinic.hasChatConsultancy)
                            const CustomTab(title: 'مشاوره متنی'),
                          if (clinic.hasLicenses)
                            const CustomTab(title: 'گواهی‌ها'),
                          if (clinic.hasExpertises)
                            const CustomTab(title: 'خدمات'),
                        ],
                      )
                    else
                      SliverDivider(margin: 20.w),
                  ],
                  body: [
                    if (clinic.hasContactInfo)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/call.svg',
                          title: 'اطلاعات تماس',
                        ),
                        child: _ContactInfo(
                          clinic: clinic,
                        ),
                      ),
                    if (clinic.hasAbout)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/document.svg',
                          title: 'درباره کلینیک',
                        ),
                        child: _AboutClinic(
                          clinic: clinic,
                        ),
                      ),
                    if (clinic.hasAddress)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/location.svg',
                          title: 'آدرس',
                        ),
                        child: Address(
                          address: clinic.address,
                          location: clinic.location,
                        ),
                      ),
                    if (clinic.hasPhoneConsultancy)
                      const ItemModel(
                        label: LabelModel(
                          icon: 'assets/images/svg/call-calling.svg',
                          title: 'مشاوره تلفنی',
                        ),
                        child: Placeholder(),
                      ),
                    if (clinic.hasChatConsultancy)
                      const ItemModel(
                        label: LabelModel(
                          icon: 'assets/images/svg/notification-status.svg',
                          title: 'مشاوره متنی',
                        ),
                        child: Placeholder(),
                      ),
                    if (clinic.hasLicenses)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/card-tick.svg',
                          title: 'گواهی‌ها',
                        ),
                        child: Licences(
                          licenses: clinic.licenses,
                        ),
                      ),
                    if (clinic.hasExpertises)
                      ItemModel(
                        label: const LabelModel(
                          icon: 'assets/images/svg/notification-status.svg',
                          title: 'خدمات',
                        ),
                        child: Expertises(
                          expertises: clinic.expertises,
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
                title: 'درخواست مشاوره و درمان حضوری',
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
