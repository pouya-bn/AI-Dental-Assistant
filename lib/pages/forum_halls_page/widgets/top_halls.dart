part of '../forum_halls_page.dart';

class _TopHalls extends HookConsumerWidget {
  const _TopHalls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(viewportFraction: 0.9);
    final topForumHalls = ref.watch(topForumHallsProvider);

    return SizedBox(
      height: 150.h,
      child: topForumHalls.when(
        data: (halls) {
          if (halls.isEmpty) {
            return const CustomEmpty(
              color: AppColors.tertiary,
            );
          }
          return Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: halls.length,
                itemBuilder: (context, index) {
                  final hall = halls[index];
                  return Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: _Card(hall: hall),
                  );
                },
              ),
              Positioned(
                bottom: 10.h,
                width: context.width,
                child: Center(
                  child: CustomIndicator(
                    isDense: true,
                    controller: pageController,
                    count: halls.length,
                    backgroundColor: Colors.black45,
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Loading(
            color: AppColors.onSecondary,
          ),
        ),
        error: (error, _) => const CustomError(
          color: AppColors.tertiary,
        ),
      ),
    );
  }
}
