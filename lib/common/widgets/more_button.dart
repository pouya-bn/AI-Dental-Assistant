import 'package:ava/common/values/imports.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
    this.size,
    this.iconSize,
    this.onTap,
  });

  final double? size;
  final double? iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? AppValues.iconButtonSize,
      height: size ?? AppValues.iconButtonSize,
      child: IconButton(
        onPressed: onTap,
        style: IconButton.styleFrom(
          highlightColor: AppColors.highlight,
        ),
        icon: CustomSvg(
          'assets/images/svg/more.svg',
          height: iconSize ?? 24.h,
          width: iconSize ?? 24.h,
        ),
      ),
    );
  }
}
