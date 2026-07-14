import 'package:ava/common/values/imports.dart';

class TagsWrap extends HookWidget {
  const TagsWrap({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final tag in tags)
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
              tag,
              style: context.labelMedium.copyWith(
                color: AppColors.onPrimary,
              ),
            ),
          ),
      ],
    );
  }
}
