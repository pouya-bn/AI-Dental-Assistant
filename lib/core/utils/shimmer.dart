import 'package:ava/common/values/imports.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({
    super.key,
    this.baseColor = AppColors.grey2,
    this.highlightColor = AppColors.grey3,
    this.duration = const Duration(milliseconds: 1000),
    required this.child,
  });

  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: duration,
      child: child,
    );
  }
}

class ShimmerSkeleton extends StatelessWidget {
  const ShimmerSkeleton({
    super.key,
    this.height,
    this.width,
    this.baseColor = AppColors.grey2,
    this.borderRadius,
  });

  final double? height;
  final double? width;
  final Color? baseColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      ),
    );
  }
}
