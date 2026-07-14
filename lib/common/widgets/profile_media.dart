import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/media_grid.dart';
import 'package:ava/core/models/doctor_model.dart';

class ProfileMedia extends StatelessWidget {
  const ProfileMedia({
    super.key,
    this.gallery,
    this.banner,
    this.fallback,
  })  : assert(
          gallery != null || banner != null || fallback != null,
          'At least one of gallery, banner, or fallback must be provided.',
        ),
        assert(
          !(gallery != null && banner != null),
          'Either gallery or banner must be provided, but not both.',
        );

  final List<MediaModel>? gallery;
  final String? banner;
  final String? fallback;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      sliver: SliverToBoxAdapter(
        child: gallery != null
            ? CustomMediaGrid(
                content: gallery!.map((e) => e.image).toList(),
                fallback: fallback,
              )
            : (banner != null
                ? Container(
                    height: 216.h,
                    width: double.maxFinite,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: customNetworkImageProvider(
                          url: banner,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}
