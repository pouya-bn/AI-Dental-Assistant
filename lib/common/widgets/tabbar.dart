import 'dart:ui';

import 'package:ava/common/values/imports.dart';

class CustomTabBar extends SliverPersistentHeaderDelegate {
  CustomTabBar(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrolled = shrinkOffset > 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: scrolled ? AppColors.blue6 : AppColors.white10,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: scrolled ? 10 : 0,
            sigmaY: scrolled ? 10 : 0,
          ),
          child: tabBar,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 40.h;

  @override
  double get minExtent => 40.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.title,
    this.style,
  });

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: style ??
            context.bodySmall.copyWith(
              color: AppColors.onPrimary,
              fontSize: 10.sp,
            ),
      ),
    );
  }
}
