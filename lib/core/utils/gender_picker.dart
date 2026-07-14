import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/providers/basic_provider.dart';

Future<GenderModel?> showGenderPicker(
  BuildContext context,
  WidgetRef ref,
) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await ref.watch(basicProvider.future);
  final genders = ref.watch(basicProvider.notifier).genders;
  if (context.mounted) {
    return await AppBottomSheet.show<GenderModel?>(
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
          itemCount: genders.length,
          itemBuilder: (context, index) {
            final gender = genders[index];
            return ListTile(
              title: Text(gender.name),
              onTap: () {
                context.pop(gender);
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
