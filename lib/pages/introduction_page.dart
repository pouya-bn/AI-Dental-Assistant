import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/indicator.dart';
import 'package:ava/core/providers/auth_provider.dart';

class IntroductionPage extends HookConsumerWidget {
  const IntroductionPage({super.key});

  static const _totalPages = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();
    final page = useState(1);
    final isLast = page.value == _totalPages;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: PageView.builder(
              controller: controller,
              itemCount: _totalPages,
              onPageChanged: (index) {
                page.value = index + 1;
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  'assets/images/intro${index + 1}.jpg',
                  fit: BoxFit.cover,
                  frameBuilder: (context, child, frame, wasSync) {
                    if (wasSync) {
                      return child;
                    }
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: frame == null ? 0 : 1,
                      child: Container(
                        color: AppColors.primary,
                        child: child,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 20.h,
            width: context.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: CustomIndicator(
                    controller: controller,
                    count: _totalPages,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                SizedBox(height: 100.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: isLast
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: CustomButton(
                      width: double.maxFinite,
                      label: 'ورود',
                      labelColor: AppColors.secondary,
                      onTap: () {
                        final introBox = Hive.box<bool>(AppStrings.introBox);
                        introBox.put(AppStrings.appIntroKey, true);
                        ref
                            .read(authProvider.notifier)
                            .set(AuthStatus.unauthenticated);
                      },
                    ),
                    secondChild: CustomButton(
                      width: double.maxFinite,
                      label: 'ادامه',
                      color: Colors.transparent,
                      labelColor: AppColors.onPrimary,
                      onTap: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
