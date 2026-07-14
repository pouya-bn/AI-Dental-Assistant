import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/action_bar.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/doctors_section.dart';
import 'package:ava/common/widgets/profile_media.dart';
import 'package:ava/common/widgets/profile_tabbar.dart';
import 'package:ava/common/widgets/section.dart';
import 'package:ava/common/widgets/sliver_sized_box.dart';
import 'package:ava/common/widgets/tabbar.dart';
import 'package:ava/common/widgets/tags_wrap.dart';
import 'package:ava/core/models/forum_model.dart';
import 'package:ava/core/providers/forum_provider.dart';
import 'package:ava/core/utils/format.dart';

part 'widgets/about_forum_hall.dart';
part 'widgets/filters.dart';
part 'widgets/forum_hall_title.dart';
part 'widgets/forum_tile.dart';
part 'widgets/tiles.dart';

class ForumHallPage extends HookConsumerWidget {
  const ForumHallPage({
    super.key,
    required this.hallId,
  });

  final String hallId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumHall = ref.watch(forumHallProvider(id: hallId));
    final forumHallTiles = ref.watch(forumHallTilesProvider(id: hallId));
    final notifier = ref.watch(forumHallTilesProvider(id: hallId).notifier);
    final scrollController = useScrollController();
    final tabController = useTabController(initialLength: 2);
    final tabIndex = useState(0);

    useEffect(() {
      tabController.addListener(() {
        tabIndex.value = tabController.index;
      });
      return null;
    }, const []);

    void onScroll() {
      final position = scrollController.positions.lastOrNull;
      if (position == null ||
          forumHallTiles.initial ||
          forumHallTiles.loading ||
          forumHallTiles.finished) {
        return;
      }
      if (position.pixels >= position.maxScrollExtent) {
        notifier.load();
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.load();
      });
      scrollController.addListener(onScroll);
      return null;
    }, []);

    return CustomScaffold(
      titleText: 'تالار گفتگو',
      body: forumHall.when(
        data: (hall) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverSizedBox(height: 20.h),
              ProfileMedia(
                banner: hall.banner,
                fallback: 'assets/images/clinic.png',
              ),
              SliverSizedBox(height: 20.h),
              _ForumHallTitle(
                hall: hall,
              ),
              SliverSizedBox(height: 20.h),
              SliverToBoxAdapter(
                child: ActionBar(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  actions: const [
                    ActionBarType.like,
                    ActionBarType.share,
                    ActionBarType.follow,
                  ],
                ),
              ),
              SliverSizedBox(height: 20.h),
              ProfileTabBar(
                tabController: tabController,
                isScrollable: false,
                tabs: [
                  CustomTab(
                    title: 'گفتگوهای مرتبط',
                    style: context.labelSmall.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                  CustomTab(
                    title: 'درباره این گفتگو',
                    style: context.labelSmall.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                ],
              ),
              if (tabIndex.value == 0) ...[
                SliverSizedBox(height: 16.h),
                const _Filters(),
                SliverSizedBox(height: 16.h),
                _Tiles(hallId: hallId),
              ] else
                _About(hall: hall),
              SliverSizedBox(height: 30.h),
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
