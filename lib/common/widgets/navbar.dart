import 'package:ava/common/values/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.items,
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<CustomNavigationBarItem> items;
  final int selectedIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;

  @override
  Widget build(BuildContext context) {
    final itemPadding = EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w);
    const itemShape = StadiumBorder();
    return Container(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
      child: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: items.length <= 2
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              TweenAnimationBuilder<double>(
                tween: Tween(
                  end: items.indexOf(item) == selectedIndex ? 1.0 : 0.0,
                ),
                curve: Curves.easeOutQuint,
                duration: const Duration(milliseconds: 500),
                builder: (context, t, _) {
                  return Material(
                    color: Color.lerp(
                      selectedItemColor.withOpacity(0.0),
                      selectedItemColor.withOpacity(1.0),
                      t,
                    ),
                    shape: itemShape,
                    child: InkWell(
                      onTap: () => onTap.call(items.indexOf(item)),
                      customBorder: itemShape,
                      focusColor: selectedItemColor.withOpacity(0.1),
                      highlightColor: selectedItemColor.withOpacity(0.1),
                      splashColor: selectedItemColor.withOpacity(0.1),
                      hoverColor: selectedItemColor.withOpacity(0.1),
                      child: Padding(
                        padding: itemPadding -
                            (Directionality.of(context) == TextDirection.ltr
                                ? EdgeInsets.only(right: itemPadding.right * t)
                                : EdgeInsets.only(left: itemPadding.left * t)),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              items.indexOf(item) == selectedIndex
                                  ? item.selectedIcon
                                  : item.icon,
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            ClipRect(
                              clipBehavior: Clip.antiAlias,
                              child: SizedBox(
                                height: 30.h,
                                child: Align(
                                  alignment: const Alignment(-0.2, 0.0),
                                  widthFactor: t,
                                  child: Padding(
                                    padding: Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? EdgeInsets.only(
                                            left: itemPadding.left / 2,
                                            right: itemPadding.right)
                                        : EdgeInsets.only(
                                            left: itemPadding.left,
                                            right: itemPadding.right / 2),
                                    child: DefaultTextStyle(
                                      style: context.bodyLarge.copyWith(
                                        color: AppColors.primary,
                                      ),
                                      child: Text(item.title),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class CustomNavigationBarItem {
  CustomNavigationBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.title,
  });

  final String icon;
  final String title;
  final String selectedIcon;
}
