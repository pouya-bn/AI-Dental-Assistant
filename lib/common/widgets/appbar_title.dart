import 'package:ava/common/values/imports.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
    this.textAlign,
    this.maxLines,
  });

  final String title;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        title,
        textAlign: textAlign,
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        style: context.labelMedium.copyWith(
          color: AppColors.onPrimary,
        ),
      ),
    );
  }
}
