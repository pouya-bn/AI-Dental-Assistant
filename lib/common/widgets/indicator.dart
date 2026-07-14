import 'package:ava/common/values/imports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.controller,
    required this.count,
    this.textDirection,
    this.isDense = false,
    this.backgroundColor,
  });

  final PageController controller;
  final int count;
  final TextDirection? textDirection;
  final bool isDense;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: SmoothPageIndicator(
        controller: controller,
        count: count,
        textDirection: textDirection,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.onPrimary,
          dotColor: AppColors.blue3,
          dotHeight: isDense ? 6.w : 8.w,
          dotWidth: isDense ? 6.w : 8.w,
          spacing: isDense ? 3.w : 4.w,
          radius: 100.r,
        ),
        onDotClicked: (index) {
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
