import 'package:ava/common/values/imports.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({
    super.key,
    this.message,
    this.color = AppColors.blue7,
  });

  final String? message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            size: 40.sp,
            color: color,
          ),
          SizedBox(height: 10.h),
          Text(
            message ?? 'اطلاعاتی وجود ندارد',
            style: context.labelSmall.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
