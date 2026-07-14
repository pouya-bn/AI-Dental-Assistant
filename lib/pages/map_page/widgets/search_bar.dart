part of '../map_page.dart';

class _SearchBar extends ConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locatedDoctors = ref.watch(locatedDoctorsProvider);
    return IntrinsicHeight(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Background(),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                const CustomAppBar(
                  titleText: 'جستجوی دندانپزشک',
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SearchField(
                    prefixIcon: locatedDoctors.maybeWhen(
                      data: (_) {
                        return const CustomSvg(
                          'assets/images/svg/search.svg',
                        );
                      },
                      orElse: () => const Loading(),
                    ),
                    onFilterTap: () {},
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
