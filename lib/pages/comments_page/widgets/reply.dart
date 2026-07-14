part of '../comments_page.dart';

class _Reply extends HookConsumerWidget {
  const _Reply({
    this.isDismissible = false,
    this.maxLines,
  });

  final bool isDismissible;
  final int? maxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        if (isDismissible) ...[
                          SizedBox(width: 10.w),
                          SizedBox(
                            height: 18.h,
                            width: 18.h,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.close,
                                color: AppColors.blue14,
                                size: 15.h,
                              ),
                              onPressed: () {
                                ref
                                    .read(commentsProvider.notifier)
                                    .setReplying(false);
                              },
                            ),
                          ),
                        ],
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
            maxLines: maxLines,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
            style: context.labelSmall.copyWith(
              color: AppColors.blue14,
            ),
          ),
        ],
      ),
    );
  }
}
