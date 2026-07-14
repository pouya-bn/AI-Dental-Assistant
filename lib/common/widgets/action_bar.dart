import 'package:ava/common/values/imports.dart';

class ActionBar extends HookConsumerWidget {
  const ActionBar({
    super.key,
    required this.actions,
    this.margin,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onDownload,
    this.onFollow,
    this.onInfo,
  });

  final List<ActionBarType> actions;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onDownload;
  final VoidCallback? onFollow;
  final VoidCallback? onInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: margin,
      height: 40.h,
      child: Row(
        mainAxisAlignment: actions.length < 3
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          if (actions.contains(ActionBarType.like))
            _Button(
              image: 'assets/images/svg/like2.svg',
              onTap: onLike,
              count: actions.length,
            ),
          if (actions.contains(ActionBarType.comment))
            _Button(
              image: 'assets/images/svg/comment2.svg',
              onTap: onComment,
              count: actions.length,
            ),
          if (actions.contains(ActionBarType.share))
            _Button(
              image: 'assets/images/svg/share2.svg',
              onTap: onShare,
              count: actions.length,
            ),
          if (actions.contains(ActionBarType.download))
            _Button(
              image: 'assets/images/svg/directbox-receive.svg',
              onTap: onDownload,
              count: actions.length,
            ),
          if (actions.contains(ActionBarType.follow))
            _Button(
              image: 'assets/images/svg/bell.svg',
              onTap: onFollow,
              count: actions.length,
            ),
          if (actions.contains(ActionBarType.info))
            _Button(
              image: 'assets/images/svg/info.svg',
              onTap: onInfo,
              count: actions.length,
            ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.image,
    this.onTap,
    required this.count,
  });

  final String image;
  final VoidCallback? onTap;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: count < 3 ? FlexFit.loose : FlexFit.tight,
      child: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: IconButton(
          style: IconButton.styleFrom(
            padding: count < 3
                ? EdgeInsets.symmetric(horizontal: 30.w)
                : EdgeInsets.zero,
            backgroundColor: AppColors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          icon: CustomSvg(
            image,
            color: AppColors.onSecondary,
            height: 24.h,
            width: 24.h,
          ),
          onPressed: onTap ?? () {},
        ),
      ),
    );
  }
}
