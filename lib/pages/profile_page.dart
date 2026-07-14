import 'package:auto_size_text/auto_size_text.dart';
import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/core/providers/auth_provider.dart';
import 'package:ava/core/providers/user_provider.dart';
import 'package:ava/core/utils/format.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      canPop: false,
      titleText: 'حساب کاربری',
      background: const Background2(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          const _UserTile(),
          SizedBox(height: 20.h),
          CustomDivider(margin: 20.w),
          Expanded(
            child: ListView(
              primary: false,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              children: [
                _OptionTile(
                  icon: 'assets/images/svg/archive-tick.svg',
                  title: 'علاقه مندی‌ها',
                  onTap: () {
                    context.push(AppRoutes.favorites);
                  },
                ),
                SizedBox(height: 20.h),
                _OptionTile(
                  icon: 'assets/images/svg/receipt-minus.svg',
                  title: 'سوابق بیماری‌ها',
                  onTap: () {
                    context.push(AppRoutes.diseaseRecords);
                  },
                ),
                SizedBox(height: 20.h),
                _OptionTile(
                  icon: 'assets/images/svg/note-2.svg',
                  title: 'سوابق معاینه‌ها',
                  onTap: () {
                    context.push(AppRoutes.examRecords);
                  },
                ),
                SizedBox(height: 20.h),
                _OptionTile(
                  icon: 'assets/images/svg/notification.svg',
                  title: 'اعلانات',
                  onTap: () {
                    context.push(AppRoutes.notifications);
                  },
                ),
                CustomDivider(height: 40.h),
                _OptionTile(
                  icon: 'assets/images/svg/setting.svg',
                  title: 'تنظیمات',
                  onTap: () {
                    context.push(AppRoutes.settings);
                  },
                ),
                SizedBox(height: 20.h),
                _OptionTile(
                  icon: 'assets/images/svg/message-question.svg',
                  title: 'سوالات متداول',
                  onTap: () {
                    context.push(AppRoutes.faq);
                  },
                ),
                SizedBox(height: 20.h),
                _OptionTile(
                  icon: 'assets/images/svg/info-circle.svg',
                  title: 'درباره اپلیکیشن',
                  onTap: () {
                    context.push(AppRoutes.about);
                  },
                ),
                SizedBox(height: 20.h),
                _OptionTile(
                  icon: 'assets/images/svg/arrow-swap-horizontal.svg',
                  title: 'تغییر حساب کاربری به دندانپزشک/کلینیک',
                  onTap: () {
                    context.push(AppRoutes.switchAccount);
                  },
                ),
                SizedBox(height: 20.h),
                _OptionTile(
                  icon: 'assets/images/svg/logout.svg',
                  title: 'خروج از حساب کاربری',
                  onTap: () {
                    _showBottomSheet(context, ref);
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Text(
              "SMART WELLNESS © ${DateTime.now().year}${AppStrings.appVersion != null ? '  v${AppStrings.appVersion}' : ''}",
              style: context.bodySmall.copyWith(
                color: AppColors.tertiary,
                fontFamily: 'AbarEnNum',
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTile extends StatefulWidget {
  const _UserTile();

  @override
  State<_UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<_UserTile> {
  @override
  Widget build(BuildContext context) {
    final avatar = getStorageUrl(self.avatarUrl);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          await context.push(AppRoutes.editUser);
          setState(() {});
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.h,
              backgroundColor: AppColors.blue4,
              backgroundImage: customNetworkImageProvider(
                url: avatar,
                fallback: 'assets/images/user.png',
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.onPrimary,
                    width: 2.w,
                  ),
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
                    self.fullName.trim().isNotEmpty
                        ? self.fullName
                        : self.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelMedium.copyWith(
                      color: AppColors.onSecondary,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'ویرایش اطلاعات کاربری',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelSmall.copyWith(
                      color: AppColors.tertiary,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Icon(
              Icons.chevron_right_rounded,
              size: 16.sp,
              color: AppColors.onSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          CustomSvg(
            icon,
            width: 24.h,
            height: 24.h,
            color: AppColors.onSecondary,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: AutoSizeText(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.labelMedium.copyWith(
                color: AppColors.onSecondary,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Icon(
            Icons.chevron_right_rounded,
            size: 16.sp,
            color: AppColors.onSecondary,
          ),
        ],
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, WidgetRef ref) {
  AppBottomSheet.show(
    context,
    title: 'آیا برای خروج مطمئن هستید؟',
    titleStyle: context.labelSmall.copyWith(
      color: AppColors.secondary,
    ),
    children: [
      SizedBox(height: 20.h),
      Row(
        children: [
          Expanded(
            child: CustomButton.outlined(
              label: 'خیر',
              onTap: () {
                context.pop();
              },
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomButton(
              label: 'بله',
              color: const Color(0xFFFC8800),
              labelColor: Colors.white,
              onTap: () {
                ref.read(authProvider.notifier).signOut();
              },
            ),
          ),
        ],
      ),
      SizedBox(height: 20.h),
    ],
  );
}
