import 'package:ava/common/values/imports.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.height,
    this.color,
    this.margin,
  });

  final double? height;
  final Color? color;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.grey20,
      height: height ?? 1.h,
      indent: margin,
      endIndent: margin,
    );
  }
}

class SliverDivider extends StatelessWidget {
  const SliverDivider({
    super.key,
    this.height,
    this.color,
    this.margin,
  });

  final double? height;
  final Color? color;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: margin != null
          ? EdgeInsets.symmetric(horizontal: margin!)
          : EdgeInsets.zero,
      sliver: SliverToBoxAdapter(
        child: Divider(
          color: color ?? AppColors.grey20,
          height: height ?? 1.h,
        ),
      ),
    );
  }
}
