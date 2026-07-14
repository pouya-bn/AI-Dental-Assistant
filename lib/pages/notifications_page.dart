import 'package:ava/common/values/imports.dart';

class NotificationsPage extends HookConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold.variant(
      titleText: 'اعلانات',
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        itemCount: 20,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (_, index) => const _NotificationTile(
          time: '',
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 46.h,
            height: 46.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.blue20,
                width: 1.w,
              ),
            ),
            child: Center(
              child: CustomSvg(
                'assets/images/svg/messages.svg',
                height: 24.h,
                width: 24.h,
                color: AppColors.blue20,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '15:30 - 03/02/02',
                  style: context.bodySmall.copyWith(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  AppStrings.loremIpsum3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.labelSmall.copyWith(
                    color: AppColors.blue20,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
