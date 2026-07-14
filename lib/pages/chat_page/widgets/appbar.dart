part of '../chat_page.dart';

class _AppBar extends ConsumerWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          width: 45.h,
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColors.blue4,
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/ava2.png',
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
          child: Text(
            'دکتر آوا کیانیان',
            style: context.labelLarge.copyWith(
              color: AppColors.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
