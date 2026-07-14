import 'package:ava/common/values/imports.dart';
import 'package:ava/core/providers/navbar_provider.dart';
import 'package:ava/pages/find_doctor_page/find_doctor_page.dart';
import 'package:ava/pages/forum_halls_page/forum_halls_page.dart';
import 'package:ava/pages/home_page.dart';
import 'package:ava/pages/profile_page.dart';

const _homeIcon = 'assets/images/svg/navbar/home.svg';
const _searchIcon = 'assets/images/svg/navbar/search.svg';
const _avaIcon = 'assets/images/svg/navbar/ava.svg';
const _messagesIcon = 'assets/images/svg/navbar/messages.svg';
const _profileIcon = 'assets/images/svg/navbar/profile.svg';

const _screens = [
  HomePage(),
  _Placeholder(),
  _Placeholder(),
  _Placeholder(),
  ProfilePage(),
];

class ShellPage extends ConsumerWidget {
  const ShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navbarProvider);
    if (index == 1) {
      return const FindDoctorPage(
        canPop: false,
        footer: _Footer(),
      );
    }
    if (index == 3) {
      return const ForumHallsPage(
        canPop: false,
        footer: _Footer(),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.secondary,
      resizeToAvoidBottomInset: false,
      body: _screens[index],
      bottomNavigationBar: const _Footer(),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _NavigationBar(),
        _IndicatorOverlay(),
      ],
    );
  }
}

class _NavigationBar extends ConsumerWidget {
  const _NavigationBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navbarProvider);
    return Theme(
      data: context.theme.copyWith(
        splashFactory: NoSplash.splashFactory,
        navigationBarTheme: NavigationBarTheme.of(context).copyWith(
          height: AppValues.navbarHeight,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return context.labelSmall.copyWith(
                  fontSize: 10.sp,
                  color: AppColors.primary,
                );
              }
              return context.labelSmall.copyWith(
                fontSize: 10.sp,
                color: AppColors.blue4,
              );
            },
          ),
        ),
      ),
      child: NavigationBar(
        height: AppValues.navbarHeight,
        elevation: 20,
        backgroundColor: AppColors.navbar,
        surfaceTintColor: AppColors.navbar,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: index,
        onDestinationSelected: (index) {
          if (index == 2) return;
          ref.read(navbarProvider.notifier).change(index);
        },
        destinations: [
          NavigationDestination(
            label: 'خانه',
            icon: _NavBarIcon.unselected(_homeIcon),
            selectedIcon: _NavBarIcon.selected(_homeIcon),
          ),
          NavigationDestination(
            label: 'جستجو پزشک',
            icon: _NavBarIcon.unselected(_searchIcon),
            selectedIcon: _NavBarIcon.selected(_searchIcon),
          ),
          GestureDetector(
            onTap: () {
              if (AppValues.chatIntroSeen) {
                context.push(AppRoutes.chat);
              } else {
                context.push(AppRoutes.chatIntro);
              }
            },
            child: Container(
              width: 53.h,
              height: 53.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.29),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: CustomSvg(
                  _avaIcon,
                  height: 26.h,
                  width: 26.h,
                ),
              ),
            ),
          ),
          NavigationDestination(
            label: 'تالار گفتگو',
            icon: _NavBarIcon.unselected(_messagesIcon),
            selectedIcon: _NavBarIcon.selected(_messagesIcon),
          ),
          NavigationDestination(
            label: 'پروفایل',
            icon: _NavBarIcon.unselected(_profileIcon),
            selectedIcon: _NavBarIcon.selected(_profileIcon),
          ),
        ],
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  const _NavBarIcon({
    required this.icon,
    this.color = AppColors.blue4,
  });

  final String icon;
  final Color color;

  factory _NavBarIcon.selected(String icon) {
    return _NavBarIcon(icon: icon, color: AppColors.primary);
  }

  factory _NavBarIcon.unselected(String icon) {
    return _NavBarIcon(icon: icon, color: AppColors.blue4);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSvg(
      icon,
      color: color,
      height: 26.h,
      width: 26.h,
    );
  }
}

class _IndicatorOverlay extends ConsumerWidget {
  const _IndicatorOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navbarProvider);
    double width = context.width;
    double position;
    if (context.isRTL) {
      position = (width / 5) * (4 - index) + (width / 10) - 23.w;
    } else {
      position = (width / 5) * index + (width / 10) - 23.w;
    }
    return Positioned(
      top: 0,
      left: position,
      child: const _Indicator(),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.w,
      height: 5.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
    );
  }
}
