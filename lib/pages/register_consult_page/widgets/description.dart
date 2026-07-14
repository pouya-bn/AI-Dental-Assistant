part of '../register_consult_page.dart';

class _Description extends HookConsumerWidget {
  const _Description();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(true);
    return Theme(
      data: context.theme.copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: ExpansionTile(
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: AppColors.blue20,
            width: 1.w,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: AppColors.blue20,
            width: 1.w,
          ),
        ),
        tilePadding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        childrenPadding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 15.h),
        initiallyExpanded: isExpanded.value,
        onExpansionChanged: (value) {
          isExpanded.value = value;
        },
        iconColor: AppColors.blue14,
        collapsedIconColor: AppColors.blue14,
        expandedAlignment: Alignment.centerRight,
        backgroundColor: AppColors.blue25,
        title: Text(
          'توضیحات',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.labelMedium.copyWith(
            color: AppColors.blue14,
          ),
        ),
        children: [
          Text(
            AppStrings.loremIpsum,
            style: context.labelSmall.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
