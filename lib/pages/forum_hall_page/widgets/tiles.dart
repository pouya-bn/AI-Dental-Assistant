part of '../forum_hall_page.dart';

class _Tiles extends HookConsumerWidget {
  const _Tiles({
    required this.hallId,
  });

  final String hallId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumHallTiles = ref.watch(forumHallTilesProvider(id: hallId));

    if (forumHallTiles.initial) {
      return Center(
        child: SizedBox(
          height: 150.h,
          child: const Loading(
            color: AppColors.onSecondary,
          ),
        ),
      );
    }

    if (forumHallTiles.data.isEmpty) {
      if (forumHallTiles.error) {
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
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemCount: forumHallTiles.data.length,
            itemBuilder: (BuildContext context, int index) {
              final tile = forumHallTiles.data[index];
              return _ForumTile(tile: tile);
            },
          ),
        ),
        if (!forumHallTiles.finished)
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: forumHallTiles.error
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
