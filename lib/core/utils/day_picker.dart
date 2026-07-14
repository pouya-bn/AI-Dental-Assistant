import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/core/models/day_model.dart';
import 'package:ava/core/providers/basic_provider.dart';

Future<DayModel?> showDayPicker(
  BuildContext context,
  WidgetRef ref,
) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await ref.watch(basicProvider.future);
  final days = ref.watch(basicProvider.notifier).days;
  if (context.mounted) {
    return await AppBottomSheet.show<DayModel?>(
      context,
      title: 'جنسیت',
      initialSnap: 1,
      children: [
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const CustomDivider(
            color: AppColors.blue11,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
            return ListTile(
              title: Text(day.name),
              onTap: () {
                context.pop(day);
              },
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
  return null;
}
