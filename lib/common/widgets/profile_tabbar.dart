import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/tab_indicator.dart';
import 'package:ava/common/widgets/tabbar.dart';
import 'package:ava/core/utils/tabbar_view.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.isScrollable = true,
    this.onTap,
  });

  final TabController tabController;
  final List<Widget> tabs;
  final bool isScrollable;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: CustomTabBar(
        TabBar(
          onTap: onTap ??
              (index) {
                CustomTabBarViewStatus.setIndex(index);
              },
          controller: tabController,
          isScrollable: isScrollable,
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
          ),
          tabAlignment: isScrollable ? TabAlignment.start : null,
          indicatorPadding: EdgeInsets.zero,
          indicatorColor: AppColors.onPrimary,
          indicator: const CustomTabIndicator(),
          dividerHeight: 0,
          tabs: tabs,
        ),
      ),
    );
  }
}
