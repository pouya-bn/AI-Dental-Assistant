import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/core/utils/launch_map.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';

class Address extends ConsumerStatefulWidget {
  const Address({
    super.key,
    this.address,
    this.location,
  });

  final String? address;
  final LatLng? location;

  @override
  ConsumerState<Address> createState() => __AddressState();
}

class __AddressState extends ConsumerState<Address>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final mapController = AnimatedMapController(vsync: this);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.address != null)
          Text(
            widget.address!,
            style: context.labelSmall.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        if (widget.location != null) ...[
          SizedBox(height: 20.h),
          Stack(
            children: [
              Container(
                height: 200.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: FlutterMap(
                  mapController: mapController.mapController,
                  options: MapOptions(
                    initialCenter: widget.location!,
                    initialZoom: 15,
                    initialRotation: 0,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.smart.ava',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: widget.location!,
                          height: 50.h,
                          width: 50.h,
                          child: const Center(
                            child: CustomSvg(
                              'assets/images/svg/dentist_marker.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5.h,
                right: 5.h,
                child: IconButton(
                  icon: const CustomSvg(
                    'assets/images/svg/locate.svg',
                  ),
                  onPressed: () async {
                    mapController.animateTo(dest: widget.location!, zoom: 15);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomButton(
            color: AppColors.grey20,
            labelColor: AppColors.onPrimary,
            height: 40.h,
            width: double.maxFinite,
            label: 'شروع مسیریابی',
            onTap: () async {
              if (Platform.isAndroid) {
                launchMapOnAndroid(widget.location!);
              } else if (Platform.isIOS) {
                launchMapOnIOS(widget.location!);
              } else {
                launchMapOnWeb(widget.location!);
              }
            },
          ),
        ],
      ],
    );
  }
}
