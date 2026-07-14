part of '../map_page.dart';

class _Map extends ConsumerStatefulWidget {
  const _Map();

  @override
  ConsumerState createState() => __MapState();
}

class __MapState extends ConsumerState<_Map> with TickerProviderStateMixin {
  late final mapController = AnimatedMapController(vsync: this);

  @override
  void initState() {
    super.initState();
    _getSelfLocation();
  }

  Future<void> _getSelfLocation({bool refresh = false}) async {
    LatLng latLng;
    if (refresh) {
      latLng = await ref.refresh(selfLocationProvider.future);
    } else {
      latLng = await ref.read(selfLocationProvider.future);
    }
    mapController.animateTo(dest: latLng, zoom: 16);
  }

  @override
  Widget build(BuildContext context) {
    final selfLocation = ref.watch(selfLocationProvider);
    final mapNotifier = ref.watch(mapProvider.notifier);
    final locatedDoctors = ref.watch(locatedDoctorsProvider);
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController.mapController,
          options: MapOptions(
            initialCenter: AppValues.defaultLocation,
            initialZoom: 11.4,
            initialRotation: 0,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            onTap: (_, __) => mapNotifier.hideDoctor(),
            onPositionChanged: (camera, __) {
              mapNotifier.hideDoctor(center: camera.center);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: AppStrings.appBundleId,
            ),
            selfLocation.maybeWhen(
              data: (latLng) {
                return MarkerLayer(
                  markers: [
                    Marker(
                      point: latLng,
                      height: 16.h,
                      width: 16.h,
                      child: const CustomSvg(
                        'assets/images/svg/my_marker.svg',
                      ),
                    ),
                  ],
                );
              },
              orElse: () => const SizedBox.shrink(),
            ),
            locatedDoctors.maybeWhen(
              data: (doctors) {
                if (doctors.isNotEmpty) {
                  return MarkerLayer(
                    markers: [
                      for (final doctor in doctors)
                        if (doctor.latitude != null && doctor.longitude != null)
                          Marker(
                            point: LatLng(doctor.latitude!, doctor.longitude!),
                            height: 50.h,
                            width: 50.h,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => mapNotifier.showDoctor(doctor),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: CustomSvg(
                                    'assets/images/svg/dentist_marker.svg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
              orElse: () => const SizedBox.shrink(),
            ),
          ],
        ),
        Positioned(
          top: 0,
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SearchBar(),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: selfLocation.when(
                  data: (_) {
                    return IconButton(
                      onPressed: _getSelfLocation,
                      icon: CustomSvg(
                        'assets/images/svg/locate.svg',
                        height: 24.h,
                        width: 24.h,
                      ),
                    );
                  },
                  error: (error, _) {
                    return IconButton(
                      onPressed: () => _getSelfLocation(refresh: true),
                      icon: CustomSvg(
                        'assets/images/svg/reload-location.svg',
                        height: 24.h,
                        width: 24.h,
                      ),
                    );
                  },
                  loading: () {
                    return Padding(
                      padding: EdgeInsets.all(10.h),
                      child: const Loading(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          bottom: ref.watch(mapProvider.notifier).isDoctorShown
              ? 0
              : -(270.h + 30.h + context.mediaQuery.padding.bottom),
          width: context.width,
          child: _DoctorCard(
            doctor: ref.watch(mapProvider),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          bottom: !ref.watch(mapProvider.notifier).isDoctorShown
              ? (88.h + 15.h + context.mediaQuery.padding.bottom)
              : -(270.h + 30.h + context.mediaQuery.padding.bottom),
          width: context.width,
          child: MapButton(
            title: 'جستجو در این ناحیه',
            onTap: () {
              ref.invalidate(locatedDoctorsProvider);
            },
          ),
        ),
      ],
    );
  }
}
