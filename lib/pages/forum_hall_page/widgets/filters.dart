part of '../forum_hall_page.dart';

class _Filters extends StatelessWidget {
  const _Filters();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 40.h,
          child: Row(
            children: [
              const Expanded(
                child: _Chip(
                  label: 'همه',
                  isSelected: true,
                ),
              ),
              SizedBox(width: 5.w),
              const Expanded(
                child: _Chip(
                  label: 'ویدیو',
                  isSelected: false,
                ),
              ),
              SizedBox(width: 5.w),
              const Expanded(
                child: _Chip(
                  label: 'اخبار',
                  isSelected: false,
                ),
              ),
              SizedBox(width: 5.w),
              const Expanded(
                child: _Chip(
                  label: 'مقاله',
                  isSelected: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            isSelected ? AppColors.blue19 : AppColors.blue19.withOpacity(0.32),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: AppColors.blue18,
          width: 1.w,
        ),
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
