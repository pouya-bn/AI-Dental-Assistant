import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/notification_button.dart';
import 'package:ava/core/providers/navbar_provider.dart';

final _key = GlobalKey();

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offset = useOffset(context, _key);
    return Scaffold(
      backgroundColor: AppColors.secondary,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Background2(),
          Positioned(
            top: offset.dy + 8.h,
            left: offset.dx,
            child: const CustomPattern(),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 20.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Title(),
                      const Spacer(),
                      NotificationButton(
                        size: 40.h,
                        iconSize: 20.h,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView(
                    primary: false,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    children: [
                      const _Card(
                        index: 1,
                        borderRadius: BorderRadius.zero,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const Expanded(
                            child: _Card(index: 2),
                          ),
                          SizedBox(width: 10.w),
                          const Expanded(
                            child: _Card(index: 3),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      const _Card(index: 4),
                    ],
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

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSvg(
          'assets/images/svg/ava.svg',
          key: _key,
          height: 45.h,
          width: 62.h,
        ),
        SizedBox(height: 7.h),
        Text(
          'دستیار سلامت مجازی',
          style: context.labelSmall.copyWith(
            color: AppColors.onPrimary,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}

class _Card extends ConsumerWidget {
  const _Card({
    required this.index,
    this.borderRadius,
  });

  final int index;
  final BorderRadiusGeometry? borderRadius;

  void _onTap(BuildContext context, WidgetRef ref) {
    switch (index) {
      case 1:
        if (AppValues.chatIntroSeen) {
          context.push(AppRoutes.chat);
        } else {
          context.push(AppRoutes.chatIntro);
        }
        break;
      case 2:
        if (AppValues.chatIntroSeen) {
          context.push(AppRoutes.chat);
        } else {
          context.push(AppRoutes.chatIntro);
        }
        break;
      case 3:
        ref.read(navbarProvider.notifier).change(3);
        break;
      case 4:
        ref.read(navbarProvider.notifier).change(1);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onTap(context, ref),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(20.r),
        ),
        child: Image.asset(
          'assets/images/home$index.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
