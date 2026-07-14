part of '../forum_page.dart';

class _OtherPeople extends HookWidget {
  const _OtherPeople();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: CustomSection(
        label: LabelModel(
          title: 'سایر عوامل',
          icon: 'assets/images/svg/note.svg',
        ),
        child: TagsWrap(
          tags: [
            'کارگردان: علی حاتمی',
            'تهیه کننده: علی معلم',
          ],
        ),
      ),
    );
  }
}
