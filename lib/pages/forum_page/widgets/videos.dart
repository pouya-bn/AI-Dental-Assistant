part of '../forum_page.dart';

class _Videos extends HookWidget {
  const _Videos();

  static const List<int> _filters = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    final filters = useState(<int>{2});
    return SliverToBoxAdapter(
      child: CustomSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomLabel(
              label: const LabelModel(
                title: 'فصل‌های حرفه‌ای باش',
              ),
              style: context.labelMedium.copyWith(
                color: AppColors.white,
              ),
              trailing: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomSvg(
                      'assets/images/svg/sort-outline.svg',
                      color: AppColors.white,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'جدیدترین',
                      style: context.labelMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 5.0,
              children: _filters.map((int filter) {
                final selected = filters.value.contains(filter);
                return FilterChip(
                  showCheckmark: false,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 2.h,
                  ),
                  backgroundColor: AppColors.secondary,
                  selectedColor: AppColors.secondary,
                  surfaceTintColor: AppColors.secondary,
                  color: WidgetStateProperty.all(AppColors.secondary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    side: BorderSide(
                      color: selected ? AppColors.white : AppColors.tertiary,
                    ),
                  ),
                  label: Text(
                    'فصل $filter',
                    style: context.labelSmall.copyWith(
                      color: selected ? AppColors.white : AppColors.tertiary,
                    ),
                  ),
                  selected: selected,
                  onSelected: (bool selected) {
                    if (selected) {
                      filters.value = Set.from(
                        filters.value..add(filter),
                      );
                    } else {
                      filters.value = Set.from(
                        filters.value..remove(filter),
                      );
                    }
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(height: 30.h),
              itemBuilder: (context, index) {
                return const _VideoCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  const _VideoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11.w),
      decoration: BoxDecoration(
        color: AppColors.white10,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              'assets/images/clinic.png',
              width: double.infinity,
              height: 150.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'حرفه‌ای باش',
                  style: context.labelMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: AppColors.tertiary,
                  ),
                ),
                child: Text(
                  'دیده شده',
                  style: context.labelSmall.copyWith(
                    color: AppColors.tertiary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'فصل2  |  قسمت 1',
            style: context.labelMedium.copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          DefaultTextStyle(
            style: context.bodySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w200,
              fontSize: 10.sp,
              height: 2,
            ),
            child: ReadMoreText(
              AppStrings.loremIpsum2,
              trimMode: TrimMode.Line,
              trimLines: 2,
              trimCollapsedText: 'بیشتر',
              trimExpandedText: 'کمتر',
              colorClickableText: AppColors.tertiary,
              lessStyle: context.bodySmall.copyWith(
                color: AppColors.tertiary,
                fontWeight: FontWeight.w200,
                fontSize: 10.sp,
              ),
              moreStyle: context.bodySmall.copyWith(
                color: AppColors.tertiary,
                fontWeight: FontWeight.w200,
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              SizedBox(
                height: 30.h,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  icon: const CustomSvg(
                    'assets/images/svg/play.svg',
                  ),
                  label: Text(
                    'پخش این قسمت',
                    style: context.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(width: 10.w),
              _Button(
                icon: 'assets/images/svg/like2.svg',
                onTap: () {},
              ),
              SizedBox(width: 5.w),
              _Button(
                icon: 'assets/images/svg/share2.svg',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.icon,
    required this.onTap,
  });

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 30.h,
      child: IconButton.outlined(
        icon: CustomSvg(
          icon,
          color: Colors.white,
          height: 20.h,
          width: 20.h,
        ),
        onPressed: onTap,
        padding: EdgeInsets.zero,
        color: AppColors.tertiary,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          side: const BorderSide(
            color: AppColors.tertiary,
          ),
        ),
      ),
    );
  }
}
