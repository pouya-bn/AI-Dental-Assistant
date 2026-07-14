import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    super.key,
    this.message,
    this.color = AppColors.blue7,
    this.onRetry,
  });

  final String? message;
  final Color color;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 40.sp,
            color: color,
          ),
          SizedBox(height: 10.h),
          Text(
            message ?? 'خطا در دریافت اطلاعات',
            style: context.labelSmall.copyWith(
              color: color,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: 20.h),
            CustomButton(
              label: 'تلاش مجدد',
              onTap: onRetry,
              labelStyle: context.labelSmall.copyWith(
                color: AppColors.secondary,
              ),
              size: Size.fromHeight(40.h),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
