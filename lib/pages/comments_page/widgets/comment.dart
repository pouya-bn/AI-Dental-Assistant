part of '../comments_page.dart';

class _Comment extends HookConsumerWidget {
  const _Comment();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34.h,
                height: 34.h,
                decoration: BoxDecoration(
                  color: AppColors.blue4,
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/user2.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: AppColors.onPrimary,
                    width: 2.w,
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'پویا برفی نژاد',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.labelSmall.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'تائید شده توسط مدیر',
                          maxLines: 1,
                          style: context.labelSmall.copyWith(
                            color: AppColors.blue14.withOpacity(0.5),
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '2 تیر 1403 - 12:12 ب.ظ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.labelSmall.copyWith(
                        color: AppColors.blue14.withOpacity(0.5),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            AppStrings.loremIpsum2,
            style: context.labelSmall.copyWith(
              color: AppColors.blue14,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(commentsProvider.notifier).setReplying(true);
                  },
                  child: Text(
                    'پاسخ دادن به این نظر',
                    style: context.labelSmall.copyWith(
                      color: AppColors.blue14,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '238',
                style: context.labelSmall.copyWith(
                  color: AppColors.blue14.withOpacity(0.5),
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(width: 2.w),
              CustomSvg(
                'assets/images/svg/like.svg',
                height: 20.h,
                width: 20.h,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
            child: Text(
              isExpanded.value ? 'پنهان کردن' : 'مشاهده 2 پاسخ',
              style: context.labelSmall.copyWith(
                color: AppColors.blue21,
                fontSize: 10.sp,
              ),
            ),
          ),
          if (isExpanded.value) ...[
            Row(
              children: [
                SizedBox(width: 34.h),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      const _Reply(),
                      SizedBox(height: 16.h),
                      const _Reply(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
