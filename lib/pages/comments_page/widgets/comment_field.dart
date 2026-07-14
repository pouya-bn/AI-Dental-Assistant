part of '../comments_page.dart';

class _CommentField extends HookConsumerWidget {
  const _CommentField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReplying =
        ref.watch(commentsProvider.select((value) => value.isReplying));
    return Container(
      color: AppColors.blue16,
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        top: 10.h,
        bottom: context.mediaQuery.viewInsets.bottom + 10.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isReplying)
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
              child: const _Reply(
                isDismissible: true,
                maxLines: 3,
              ),
            ),
          CustomTextField(
            style: context.bodyMedium.copyWith(
              color: AppColors.secondary,
            ),
            hintText: 'نظر خود را بنویسید...',
            hintStyle: context.bodyMedium.copyWith(
              color: AppColors.blue22,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 50.h,
              maxWidth: 50.h,
              minHeight: 34.h,
              maxHeight: 34.h,
            ),
            prefixIcon: const Center(
              child: CircleAvatar(
                backgroundColor: AppColors.blue4,
                backgroundImage: AssetImage(
                  'assets/images/user2.png',
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: 45.h,
              maxWidth: 45.h,
              minHeight: 40.h,
              maxHeight: 40.h,
            ),
            suffixIcon: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 40.h,
                width: 40.h,
                child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  icon: const CustomSvg(
                    'assets/images/svg/send3.svg',
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
