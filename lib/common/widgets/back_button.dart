import 'package:ava/common/values/imports.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.size,
    this.iconSize,
  });

  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? AppValues.iconButtonSize,
      height: size ?? AppValues.iconButtonSize,
      child: IconButton(
        onPressed: context.pop,
        style: IconButton.styleFrom(
          highlightColor: AppColors.highlight,
        ),
        icon: CustomSvg(
          'assets/images/svg/arrow_right.svg',
          height: 24.h,
          width: 24.h,
        ),
      ),
    );
  }
}
