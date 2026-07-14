import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/rating_stars.dart';

class ProfileRating extends StatelessWidget {
  const ProfileRating({
    super.key,
    required this.commentCount,
    required this.rate,
  });

  final int commentCount;
  final int rate;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      sliver: SliverToBoxAdapter(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push(AppRoutes.reviews),
          child: Row(
            children: [
              const CustomLabel(
                label: LabelModel(
                  icon: 'assets/images/svg/message.svg',
                  title: 'نمایش نظرات',
                ),
              ),
              const Spacer(),
              Text(
                '$commentCount نظر  |  $rate',
                style: context.labelSmall.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
              SizedBox(width: 5.w),
              CustomRatingStars(
                value: rate.toDouble(),
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
      ),
    );
  }
}
