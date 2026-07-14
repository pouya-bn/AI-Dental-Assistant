import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/doctor_model.dart';

class Expertises extends HookWidget {
  const Expertises({
    super.key,
    required this.expertises,
  });

  final List<ExpertiseModel> expertises;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final expertise in expertises)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 15.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.white10,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              expertise.name,
              style: context.labelMedium.copyWith(
                color: AppColors.onPrimary,
              ),
            ),
          ),
      ],
    );
  }
}
