import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/doctor_model.dart';

class Licences extends HookWidget {
  const Licences({
    super.key,
    required this.licenses,
  });

  final List<LicenseModel> licenses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: ListView.separated(
        itemCount: licenses.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final license = licenses[index];
          return _License(
            image: license.image,
            title: license.type.name,
          );
        },
      ),
    );
  }
}

class _License extends StatelessWidget {
  const _License({
    required this.title,
    this.image,
  });

  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150.w,
          height: 107.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: CustomNetworkImage(
            url: image,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          title,
          style: context.labelSmall.copyWith(
            color: AppColors.onPrimary,
          ),
        ),
      ],
    );
  }
}
