import 'package:ava/common/values/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    this.url,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.loadingWidget,
    this.errorWidget,
    this.fallback,
    this.fallbackFit = BoxFit.cover,
    this.fallbackHeight,
    this.fallbackWidth,
    this.fallbackMargin,
    this.onTap,
  });

  final String? url;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final String? fallback;
  final BoxFit fallbackFit;
  final double? fallbackHeight;
  final double? fallbackWidth;
  final EdgeInsetsGeometry? fallbackMargin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      height: height,
      width: width,
      fit: fit,
      imageBuilder: (context, imageProvider) {
        return InkWell(
          onTap: onTap,
          child: Image(
            image: imageProvider,
            height: height,
            width: width,
            fit: fit,
          ),
        );
      },
      placeholder: (context, url) {
        if (loadingWidget != null) return loadingWidget!;
        return const ShimmerWrapper(
          child: ShimmerSkeleton(),
        );
      },
      errorWidget: (context, url, error) {
        if (errorWidget != null) return errorWidget!;
        if (fallback != null) {
          return Padding(
            padding: fallbackMargin ?? EdgeInsets.zero,
            child: Image.asset(
              fallback!,
              height: fallbackHeight ?? height,
              width: fallbackWidth ?? width,
              fit: fallbackFit,
            ),
          );
        }
        return Container(
          color: AppColors.blue4,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: AppColors.error,
                  size: 25.sp,
                ),
                Text(
                  'خطا',
                  style: context.bodySmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

ImageProvider customNetworkImageProvider({
  String? url,
  String? fallback,
}) {
  if (url != null && url.trim().isNotEmpty) {
    return CachedNetworkImageProvider(url);
  }
  if (fallback != null) {
    return AssetImage(fallback);
  }
  return const AssetImage(
    'assets/images/image.png',
  );
}
