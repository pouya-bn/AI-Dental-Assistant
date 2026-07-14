import 'dart:math';

import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/rating_stars.dart';

class ReviewsPage extends HookConsumerWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          IntrinsicHeight(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/background2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -80.h,
                  right: 80.w,
                  child: const CustomPattern(),
                ),
                SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
                      const CustomAppBar(
                        titleText: 'نظرات کاربران',
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Row(
              children: [
                const CustomSvg(
                  'assets/images/svg/message.svg',
                  color: AppColors.secondary,
                ),
                SizedBox(width: 10.w),
                Text(
                  '107 نظر  |  5.0',
                  style: context.labelMedium.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(width: 5.w),
                const CustomRatingStars(
                  value: 5,
                ),
                SizedBox(width: 5.w),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 16.sp,
                  color: AppColors.onPrimary,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              itemCount: 10,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (_, __) => const _ReviewCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.outlineVariant,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'مشاوره متنی',
                style: context.labelSmall.copyWith(
                  color: AppColors.blue7,
                  fontSize: 10.sp,
                ),
              ),
              const Spacer(),
              CustomRatingStars(
                value: Random().nextInt(5) + 1,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'پویا',
            style: context.labelSmall.copyWith(
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'درمان خیلی خوبی بود، محیط خوب، بعد از درمان هم تماس گرفتن و همه چی خوب بود.',
            style: context.labelSmall.copyWith(
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            '2 خرداد 1403',
            style: context.labelSmall.copyWith(
              color: AppColors.blue7,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
