import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/core/models/media_page_params.dart';
import 'package:ava/core/utils/gallery_saver.dart';
import 'package:photo_view/photo_view.dart';

class MediaPage extends HookConsumerWidget {
  const MediaPage({
    super.key,
    required this.params,
  });

  final MediaPageParams params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            CustomAppBar(
              actions: params.canSave
                  ? [
                      IconButton(
                        icon: loading.value
                            ? Loading(
                                color: Colors.white,
                                radius: 10.sp,
                              )
                            : const Icon(
                                Icons.save_alt_rounded,
                                color: Colors.white,
                              ),
                        style: IconButton.styleFrom(
                          highlightColor: AppColors.highlight,
                        ),
                        onPressed: () async {
                          loading.value = true;
                          await saveImageToGallery(params.image);
                          loading.value = false;
                        },
                      ),
                    ]
                  : null,
            ),
            SizedBox(height: 10.h),
            const CustomDivider(),
            Expanded(
              child: PhotoView(
                imageProvider: params.image,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                loadingBuilder: (_, __) => const Center(
                  child: Loading(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
