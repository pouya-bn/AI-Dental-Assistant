import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';

class ChatIntroPage extends StatelessWidget {
  const ChatIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: const Background2(),
      hasDivider: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: (context.height / 3),
            left: (context.width / 2),
            child: const CustomPattern(),
          ),
          Positioned(
            bottom: 214.h,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/ava.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 234.h,
            left: 0,
            right: 0,
            child: Container(
              height: 195.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00003EAA),
                    Color(0xFF001944),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 254.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.blue8,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.h),
                  topRight: Radius.circular(20.h),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'سلام من آوا هستم',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: context.headlineLarge.copyWith(
                        color: AppColors.onSecondary,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'نخستین اینفلوئنسر هوش مصنوعی دندانپزشکی',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: context.labelLarge.copyWith(
                        color: AppColors.onSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    width: double.maxFinite,
                    label: 'شروع',
                    labelColor: AppColors.onBackground,
                    onTap: () {
                      final introBox = Hive.box<bool>(AppStrings.introBox);
                      introBox.put(AppStrings.chatIntroKey, true);
                      context.push(AppRoutes.chat);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
