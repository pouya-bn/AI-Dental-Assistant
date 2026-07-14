import 'package:ava/common/values/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    this.imageUrl,
    this.borderWidth,
    this.borderColor = AppColors.onBackground,
    this.onTap,
    this.height,
    this.width,
  });

  final String? imageUrl;
  final double? borderWidth;
  final Color borderColor;
  final double? height;
  final double? width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            height: 28.sp,
            width: 28.sp,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: AppColors.grey2,
              shape: CircleBorder(
                side: borderWidth != null
                    ? BorderSide(
                        width: borderWidth!,
                        color: borderColor,
                      )
                    : BorderSide.none,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: CachedNetworkImage(
                height: 28.sp,
                width: 28.sp,
                fit: BoxFit.cover,
                imageUrl: imageUrl ?? '',
                progressIndicatorBuilder: (_, __, ___) {
                  return ShimmerWrapper(
                    baseColor: AppColors.grey2,
                    child: Container(color: AppColors.background),
                  );
                },
                errorWidget: (_, url, error) {
                  // TODO: Add error image
                  // logger.d("Avatar URL: $url\nAvatar Error: $error");
                  return Image.asset(
                      imageUrl ?? 'assets/images/temp/user2.jpg');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
