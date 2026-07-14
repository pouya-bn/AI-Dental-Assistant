part of '../forum_hall_page.dart';

class _ForumTile extends StatelessWidget {
  const _ForumTile({
    required this.tile,
  });

  final ForumTileModel tile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.forum);
      },
      child: Container(
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          color: AppColors.white10,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tile.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.labelMedium.copyWith(
                color: AppColors.onSecondary,
              ),
            ),
            SizedBox(height: 20.h),
            if (tile.leadText != null) ...[
              Text(
                tile.leadText!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.bodySmall.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
              SizedBox(height: 20.h),
            ],
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                if (tile.authorName != null)
                  _Tag(
                    label: tile.authorName!,
                    avatar: tile.authorAvatar,
                  ),
                if (tile.categoryName != null)
                  _Tag(
                    label: tile.categoryName!,
                  ),
                if (tile.createdOn != null)
                  _Tag(
                    label: formatCreatedOn(tile.createdOn!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.label,
    this.avatar,
  });

  final String label;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (avatar != null)
            Container(
              width: 26.h,
              height: 26.h,
              margin: EdgeInsets.fromLTRB(0, 2.h, 2.h, 2.h),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: customNetworkImageProvider(
                    url: avatar,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              right: avatar != null ? 5.w : 10.w,
              left: 10.w,
              top: 4.h,
              bottom: 4.h,
            ),
            child: Text(
              label,
              maxLines: 1,
              style: context.labelSmall.copyWith(
                color: AppColors.blue19,
                fontSize: 10.sp,
                height: 1.75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
