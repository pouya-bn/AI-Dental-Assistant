import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/checkbox.dart';
import 'package:ava/common/widgets/map_button.dart';
import 'package:ava/common/widgets/radio.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/core/providers/find_doctor_provider.dart';
import 'package:ava/core/providers/map_provider.dart';
import 'package:latlong2/latlong.dart';

part 'widgets/bottom_sheet.dart';
part 'widgets/card.dart';
part 'widgets/content.dart';
part 'widgets/label.dart';
part 'widgets/tile.dart';

class FindDoctorPage extends HookConsumerWidget {
  const FindDoctorPage({
    super.key,
    this.canPop = true,
    this.footer,
  });

  final bool canPop;
  final Widget? footer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latLng = useState(AppValues.defaultLocation);
    final foundDoctorsResult = ref.watch(findDoctorResultProvider);
    final searchController = useTextEditingController();
    final hasQuery = useState(false);
    useEffect(() {
      searchController.addListener(() {
        hasQuery.value = searchController.text.isNotEmpty;
      });
      return null;
    }, const []);

    Future<void> getSelfLocation({bool refresh = false}) async {
      if (refresh) {
        latLng.value = await ref.refresh(selfLocationProvider.future);
      } else {
        latLng.value = await ref.read(selfLocationProvider.future);
      }
    }

    useEffect(() {
      getSelfLocation();
      return;
    }, []);

    return CustomScaffold(
      canPop: canPop,
      titleText: 'جستجوی دندانپزشک',
      hasDivider: false,
      footer: footer,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SearchField(
              controller: searchController,
              onChanged: (query) {
                ref.read(findDoctorResultProvider.notifier).find(
                      latLng: latLng.value,
                      query: query,
                    );
              },
              onFilterTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _showFilterBottomSheet(context);
              },
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  children: [
                    foundDoctorsResult.when(
                      data: (doctorResults) {
                        if (doctorResults.isEmpty) {
                          if (!hasQuery.value) {
                            return _Content(
                              latLng: latLng.value,
                            );
                          }
                          return SizedBox(
                            height: context.height / 3,
                            child: const Center(
                              child: CustomEmpty(
                                color: AppColors.tertiary,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 60.h),
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemCount: doctorResults.length,
                          itemBuilder: (_, index) {
                            final result = doctorResults[index];
                            return _Tile(
                              id: result.id,
                              name: result.name,
                              studyField: result.studyField,
                              avatar: result.avatar,
                              rating: 5.0,
                              phone: 123456789,
                            );
                          },
                        );
                      },
                      loading: () => SizedBox(
                        height: context.height / 3,
                        child: const Center(
                          child: Loading(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      error: (error, _) => SizedBox(
                        height: context.height / 3,
                        child: const Center(
                          child: CustomError(),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10.h,
                  width: context.width,
                  child: MapButton(
                    title: 'جستجو روی نقشه',
                    backgroundColor: AppColors.blue16,
                    foregroundColor: AppColors.blue17,
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.push(AppRoutes.map);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
