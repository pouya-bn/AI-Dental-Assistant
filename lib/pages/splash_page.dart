import 'package:ava/common/values/imports.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: AppColors.primary,
      child: Image.asset(
        'assets/images/splash.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
