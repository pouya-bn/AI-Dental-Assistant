import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/core/models/education_model.dart';
import 'package:ava/core/providers/basic_provider.dart';

Future<EducationModel?> showEducationPicker(
  BuildContext context,
  WidgetRef ref,
) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await ref.watch(basicProvider.future);
  final educations = ref.watch(basicProvider.notifier).educations;
  if (context.mounted) {
    return await AppBottomSheet.show<EducationModel?>(
      context,
      title: 'تحصیلات',
      initialSnap: 1,
      children: [
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const CustomDivider(
            color: AppColors.blue11,
          ),
          itemCount: educations.length,
          itemBuilder: (context, index) {
            final education = educations[index];
            return ListTile(
              title: Text(education.name),
              onTap: () {
                context.pop(education);
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
