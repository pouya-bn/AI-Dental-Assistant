import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/sliver_sized_box.dart';
import 'package:ava/common/widgets/textfield.dart';
import 'package:ava/core/providers/comments_provider.dart';

part 'widgets/comment.dart';
part 'widgets/comment_field.dart';
part 'widgets/reply.dart';

class CommentsPage extends HookConsumerWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold.variant(
      titleText: 'نظرات',
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: CustomScrollView(
        slivers: [
          SliverSizedBox(height: 20.h),
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomSvg(
                  'assets/images/svg/exam_header.svg',
                  width: context.width,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      '27',
                      style: context.headlineLarge.copyWith(
                        color: AppColors.secondary,
                        fontSize: 40.sp,
                        height: 0.8,
                      ),
                    ),
                    Text(
                      'تعداد افرادی که این تالار را پسندیدند',
                      style: context.labelSmall.copyWith(
                        color: AppColors.secondary,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverSizedBox(height: 20.h),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'نظرات کاربران',
                    style: context.headlineMedium.copyWith(
                      color: AppColors.blue14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      backgroundColor: Colors.transparent,
                      side: BorderSide(
                        color: AppColors.secondary,
                        width: 1.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    icon: const CustomSvg(
                      'assets/images/svg/sort.svg',
                      color: AppColors.secondary,
                    ),
                    label: Text(
                      'جدیدترین',
                      style: context.labelSmall.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverSizedBox(height: 15.h),
          const SliverDivider(
            color: AppColors.blue11,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            sliver: SliverList.separated(
              itemCount: 10,
              separatorBuilder: (_, __) => CustomDivider(
                color: AppColors.blue11,
                height: 10.h,
              ),
              itemBuilder: (_, index) => const _Comment(),
            ),
          ),
        ],
      ),
      footer: const _CommentField(),
    );
  }
}
