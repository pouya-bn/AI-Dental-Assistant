part of '../forum_page.dart';

class _Gallery extends HookWidget {
  const _Gallery();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomSection(
        padding: EdgeInsets.symmetric(
          vertical: 30.h,
        ),
        labelMargin: 20.w,
        label: const LabelModel(
          title: 'گالری',
          icon: 'assets/images/svg/note.svg',
        ),
        child: SizedBox(
          height: 107.h,
          child: ListView.separated(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              return Container(
                width: 150.w,
                height: 107.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.blue24,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
