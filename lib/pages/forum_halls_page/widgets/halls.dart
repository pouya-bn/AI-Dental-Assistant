part of '../forum_halls_page.dart';

class _Halls extends HookConsumerWidget {
  const _Halls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumHalls = ref.watch(forumHallsProvider);

    if (forumHalls.initial) {
      return Center(
        child: SizedBox(
          height: 150.h,
          child: const Loading(
            color: AppColors.onSecondary,
          ),
        ),
      );
    }

    if (forumHalls.data.isEmpty) {
      if (forumHalls.error) {
        return Center(
          child: SizedBox(
            height: 150.h,
            child: const CustomError(
              color: AppColors.tertiary,
            ),
          ),
        );
      }
      return Center(
        child: SizedBox(
          height: 150.h,
          child: const CustomEmpty(
            color: AppColors.tertiary,
          ),
        ),
      );
    }

    return CustomScrollView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          sliver: SliverList.separated(
            separatorBuilder: (_, __) => Divider(
              color: AppColors.white20,
              thickness: 1,
              height: 40.h,
            ),
            itemCount: forumHalls.data.length,
            itemBuilder: (BuildContext context, int index) {
              final hall = forumHalls.data[index];
              return _Tile(hall: hall);
            },
          ),
        ),
        if (!forumHalls.finished)
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: forumHalls.error
                    ? const CustomError(
                        color: AppColors.tertiary,
                      )
                    : const Loading(
                        color: AppColors.onSecondary,
                      ),
              ),
            ),
          )
      ],
    );
  }
}
