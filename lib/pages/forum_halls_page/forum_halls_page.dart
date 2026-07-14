import 'dart:math' as math;

import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/indicator.dart';
import 'package:ava/common/widgets/media_grid.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/core/models/forum_model.dart';
import 'package:ava/core/providers/forum_provider.dart';
import 'package:ava/core/utils/format.dart';

part 'widgets/about_forum_halls.dart';
part 'widgets/card.dart';
part 'widgets/filters.dart';
part 'widgets/forum_halls_title.dart';
part 'widgets/halls.dart';
part 'widgets/media.dart';
part 'widgets/rating.dart';
part 'widgets/tile.dart';
part 'widgets/top_halls.dart';

class ForumHallsPage extends HookConsumerWidget {
  const ForumHallsPage({
    super.key,
    this.canPop = true,
    this.footer,
  });

  final bool canPop;
  final Widget? footer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final searchController = useTextEditingController();
    final forumHalls = ref.watch(forumHallsProvider);
    final notifier = ref.watch(forumHallsProvider.notifier);

    void onScroll() {
      final position = scrollController.positions.lastOrNull;
      if (position == null ||
          forumHalls.initial ||
          forumHalls.loading ||
          forumHalls.finished) {
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

    useDebouncedSearch(
      searchController,
      onDebounce: (value) {
        notifier.load(query: value.isNotEmpty ? value : null);
      },
    );

    return CustomScaffold(
      canPop: canPop,
      titleText: 'تالارهای گفتگو',
      hasDivider: false,
      footer: footer,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SearchField(
              controller: searchController,
              onClear: searchController.clear,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              children: [
                const _Label(
                  label: 'برترین تالارهای گفتگو',
                ),
                SizedBox(height: 15.h),
                const _TopHalls(),
                SizedBox(height: 30.h),
                const _Label(
                  label: 'تالارهای گفتگو',
                ),
                SizedBox(height: 15.h),
                const _Halls(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        label,
        style: context.labelLarge.copyWith(
          color: AppColors.onSecondary,
        ),
      ),
    );
  }
}
