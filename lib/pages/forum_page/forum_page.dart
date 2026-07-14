import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/action_bar.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/profile_media.dart';
import 'package:ava/common/widgets/section.dart';
import 'package:ava/common/widgets/sliver_sized_box.dart';
import 'package:ava/common/widgets/tags_wrap.dart';
import 'package:readmore/readmore.dart';

part 'widgets/doctors.dart';
part 'widgets/episodes.dart';
part 'widgets/forum_title.dart';
part 'widgets/gallery.dart';
part 'widgets/info.dart';
part 'widgets/other_people.dart';
part 'widgets/trailers.dart';
part 'widgets/videos.dart';

class ForumPage extends HookConsumerWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final tabIndex = useState(0);
    useEffect(() {
      tabController.addListener(() {
        tabIndex.value = tabController.index;
      });
      return null;
    }, const []);
    return CustomScaffold(
      titleText: 'بهداشت دهان و دندان',
      body: CustomScrollView(
        slivers: [
          SliverSizedBox(height: 20.h),
          const ProfileMedia(
            gallery: null,
            fallback: 'assets/images/clinic.png',
          ),
          SliverSizedBox(height: 20.h),
          const _ForumTitle(),
          SliverSizedBox(height: 20.h),
          SliverToBoxAdapter(
            child: ActionBar(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              actions: const [
                ActionBarType.like,
                ActionBarType.comment,
                ActionBarType.share,
                ActionBarType.download,
                ActionBarType.follow,
                ActionBarType.info,
              ],
            ),
          ),
          SliverSizedBox(height: 20.h),
          SliverDivider(margin: 20.w),
          const _Info(),
          SliverDivider(margin: 20.w),
          const _Episodes(),
          SliverDivider(margin: 20.w),
          const _Videos(),
          SliverDivider(margin: 20.w),
          const _Doctors(),
          SliverDivider(margin: 20.w),
          const _OtherPeople(),
          SliverDivider(margin: 20.w),
          const _Gallery(),
          SliverDivider(margin: 20.w),
          const _Trailers(),
        ],
      ),
    );
  }
}
