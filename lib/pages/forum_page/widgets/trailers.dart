part of '../forum_page.dart';

class _Trailers extends HookWidget {
  const _Trailers();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomSection(
        padding: EdgeInsets.symmetric(
          vertical: 30.h,
        ),
        labelMargin: 20.w,
        label: const LabelModel(
          title: 'تریلرها',
          icon: 'assets/images/svg/note.svg',
        ),
        child: SizedBox(
          height: 170.h,
          child: ListView.separated(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              return const _Trailer(
                title: 'حرفه‌ای باش\nفصل 2  |  قسمت 1',
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Trailer extends StatelessWidget {
  const _Trailer({
    required this.title,
    this.image,
  });

  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150.w,
          height: 107.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.blue24,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          title,
          style: context.labelSmall.copyWith(
            color: AppColors.onPrimary,
          ),
        ),
      ],
    );
  }
}
