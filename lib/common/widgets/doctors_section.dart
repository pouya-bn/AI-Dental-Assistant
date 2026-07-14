import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/forum_model.dart';

class DoctorsSection extends HookWidget {
  const DoctorsSection({
    super.key,
    required this.doctors,
  });

  final List<ForumManagerModel> doctors;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: doctors.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return _DoctorTile(
          name: doctor.name,
          avatar: doctor.avatarUrl,
          specialty: doctor.speciality,
        );
      },
    );
  }
}

class _DoctorTile extends StatelessWidget {
  const _DoctorTile({
    required this.name,
    required this.avatar,
    required this.specialty,
  });

  final String name;
  final String? avatar;
  final String? specialty;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50.h,
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.blue4,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: customNetworkImageProvider(
                url: avatar,
                fallback: 'assets/images/user2.png',
              ),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: AppColors.onPrimary,
              width: 2.w,
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
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(
                  color: AppColors.onSecondary,
                ),
              ),
              if (specialty != null) ...[
                SizedBox(height: 6.h),
                Text(
                  specialty!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.labelSmall.copyWith(
                    color: AppColors.tertiary,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Icon(
          Icons.chevron_right_rounded,
          size: 16.sp,
          color: AppColors.onPrimary,
        ),
      ],
    );
  }
}
