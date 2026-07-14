part of '../forum_hall_page.dart';

class _About extends StatelessWidget {
  const _About({
    required this.hall,
  });

  final ForumHallModel hall;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hall.description != null) ...[
            CustomSection(
              label: const LabelModel(
                title: 'اطلاعات این تالار',
                icon: 'assets/images/svg/story.svg',
              ),
              child: Text(
                hall.description!,
                style: context.labelSmall.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
            ),
            CustomDivider(margin: 20.w),
          ],
          if (hall.rules != null) ...[
            CustomSection(
              label: const LabelModel(
                title: 'قوانین',
                icon: 'assets/images/svg/story.svg',
              ),
              child: Text(
                hall.rules!,
                style: context.labelSmall.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
            ),
            CustomDivider(margin: 20.w),
          ],
          if (hall.managers?.isNotEmpty ?? false) ...[
            CustomSection(
              label: const LabelModel(
                title: 'مدیران',
                icon: 'assets/images/svg/user-tag.svg',
              ),
              child: DoctorsSection(
                doctors: hall.managers!,
              ),
            ),
            CustomDivider(margin: 20.w),
          ],
          if (hall.tags?.isNotEmpty ?? false)
            CustomSection(
              label: const LabelModel(
                title: 'تگ‌های مرتبط با تالار',
                icon: 'assets/images/svg/note.svg',
              ),
              child: TagsWrap(
                tags: hall.tags!,
              ),
            ),
        ],
      ),
    );
  }
}
