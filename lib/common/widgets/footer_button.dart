import 'package:ava/common/values/imports.dart';

class FooterButton extends StatelessWidget {
  const FooterButton({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        color: AppColors.green1,
        child: SafeArea(
          child: Center(
            child: Text(
              title,
              style: context.labelMedium.copyWith(
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
