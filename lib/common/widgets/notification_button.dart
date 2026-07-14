import 'package:ava/common/values/imports.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
    this.size,
    this.iconSize,
    this.visualDensity,
  });

  final double? size;
  final double? iconSize;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 40.h,
      height: size ?? 40.h,
      child: IconButton(
        onPressed: () => context.push(AppRoutes.notifications),
        visualDensity: visualDensity,
        style: IconButton.styleFrom(
          highlightColor: AppColors.blue4.withOpacity(0.2),
        ),
        icon: CustomSvg(
          'assets/images/svg/notification.svg',
          height: iconSize ?? 24.h,
          width: iconSize ?? 24.h,
        ),
      ),
    );
  }
}
