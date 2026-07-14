import 'package:ava/common/values/imports.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class CustomRatingStars extends StatelessWidget {
  const CustomRatingStars({
    super.key,
    required this.value,
    this.onValueChanged,
  });

  final double value;
  final Function(double)? onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: RatingStars(
        value: value,
        maxValue: 5,
        starCount: 5,
        starSize: 12.h,
        starSpacing: 1.w,
        maxValueVisibility: false,
        valueLabelVisibility: false,
        starOffColor: AppColors.grey2,
        starColor: AppColors.amber,
        animationDuration: const Duration(milliseconds: 500),
        starBuilder: (index, color) => CustomSvg(
          'assets/images/svg/star.svg',
          color: color,
        ),
        onValueChanged: onValueChanged,
      ),
    );
  }
}
