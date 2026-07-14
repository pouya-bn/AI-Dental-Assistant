import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/doctor_tile.dart';
import 'package:ava/common/widgets/map_button.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/core/models/doctor_model.dart';
import 'package:ava/core/providers/map_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

part 'widgets/doctor_card.dart';
part 'widgets/map.dart';
part 'widgets/search_bar.dart';

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(mapProvider.notifier);
    return Material(
      child: SnappingBottomSheet(
        controller: notifier.sheetController,
        elevation: 4,
        cornerRadius: 36.r,
        closeOnBackdropTap: true,
        addTopViewPaddingOnFullscreen: true,
        cornerRadiusOnFullscreen: 0,
        duration: const Duration(milliseconds: 400),
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.11, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        body: const _Map(),
        color: AppColors.blue5,
        headerBuilder: (_, __) => const _Header(),
        builder: (context, state) => const _Sheet(),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locatedDoctors = ref.watch(locatedDoctorsProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Notch(),
          SizedBox(height: 30.h),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  locatedDoctors.when(
                    data: (doctors) {
                      if (doctors.isEmpty) {
                        return 'دندانپزشکان فعال این ناحیه';
                      }
                      return '${doctors.length} دندانپزشک فعال در این ناحیه';
                    },
                    loading: () => 'در حال جستجو...',
                    error: (error, _) => 'خطا در دریافت اطلاعات',
                  ),
                  style: context.headlineSmall.copyWith(
                    color: AppColors.onSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Sheet extends ConsumerWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locatedDoctors = ref.watch(locatedDoctorsProvider);
    return locatedDoctors.when(
      data: (doctors) {
        if (doctors.isEmpty) {
          return SizedBox(
            height: 300.h,
            child: const CustomEmpty(
              message: 'دندانپزشکی در این ناحیه یافت نشد',
              color: AppColors.tertiary,
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          itemCount: doctors.length,
          separatorBuilder: (_, __) => SizedBox(height: 20.h),
          itemBuilder: (_, index) {
            final doctor = doctors[index];
            return DoctorTile(
              id: doctor.id,
              name: doctor.name,
              studyField: doctor.studyField,
              image: doctor.avatar,
              rating: 0.0,
              totalReviews: 0,
            );
          },
        );
      },
      loading: () => SizedBox(
        height: 300.h,
        child: const Center(
          child: Loading(
            color: AppColors.onSecondary,
          ),
        ),
      ),
      error: (error, _) => SizedBox(
        height: 300.h,
        child: const CustomError(),
      ),
    );
  }
}
