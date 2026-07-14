part of '../forum_halls_page.dart';

class _Filters extends StatelessWidget {
  const _Filters();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40.h,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColors.onPrimary,
                    width: 1.w,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5.w),
                    const Expanded(
                      child: _FilterChip(
                        label: 'پربازدیدترین',
                      ),
                    ),
                    SizedBox(width: 5.w),
                    const Expanded(
                      child: _FilterChip(
                        label: 'جدیدترین',
                      ),
                    ),
                    SizedBox(width: 5.w),
                    const Expanded(
                      child: _FilterChip(
                        label: 'بیشتر',
                      ),
                    ),
                    SizedBox(width: 5.w),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              width: 40.h,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.outlineVariant,
                  width: 1.w,
                ),
              ),
              child: const Center(
                child: CustomSvg(
                  'assets/images/svg/filter2.svg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white10,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: context.labelSmall.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
