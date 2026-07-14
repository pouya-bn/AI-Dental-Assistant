import 'package:ava/common/values/imports.dart';

class MapButton extends ConsumerWidget {
  const MapButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor = AppColors.blue5,
    this.foregroundColor = AppColors.onSecondary,
  });

  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        icon: CustomSvg(
          'assets/images/svg/map-outline.svg',
          color: foregroundColor,
        ),
        label: Text(
          title,
          style: context.labelSmall.copyWith(
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
