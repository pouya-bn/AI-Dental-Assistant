import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/core/models/sickness_model.dart';
import 'package:ava/core/providers/basic_provider.dart';

Future<SicknessModel?> showSicknessPicker(
  BuildContext context,
) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (context.mounted) {
    return await AppBottomSheet.show<SicknessModel?>(
      context,
      title: 'بیماری ها',
      initialSnap: 0.8,
      children: [
        const _Sicknesses(),
      ],
    );
  }
  return null;
}

class _Sicknesses extends HookConsumerWidget {
  const _Sicknesses();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sicknesses = ref.watch(sicknessProvider);
    final controller = useTextEditingController();
    useDebouncedSearch(
      controller,
      onDebounce: (value) {
        if (value.isEmpty) {
          ref.read(sicknessProvider.notifier).getAll();
        } else {
          ref.read(sicknessProvider.notifier).search(value);
        }
      },
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchField(
          controller: controller,
          onClear: controller.clear,
        ),
        SizedBox(height: 10.h),
        sicknesses.when(
          data: (sicknesses) {
            if (sicknesses.isEmpty) {
              return SizedBox(
                height: 400.h,
                child: const Center(
                  child: CustomEmpty(),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const CustomDivider(
                  color: AppColors.blue11,
                ),
                itemCount: sicknesses.length,
                itemBuilder: (context, index) {
                  final sickness = sicknesses[index];
                  return ListTile(
                    title: Text(sickness.name),
                    subtitle: Text(
                      sickness.category,
                      style: context.bodySmall.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                    onTap: () {
                      context.pop(sickness);
                    },
                  );
                },
              ),
            );
          },
          loading: () => SizedBox(
            height: 400.h,
            child: const Center(
              child: Loading(),
            ),
          ),
          error: (error, _) => SizedBox(
            height: 400.h,
            child: const Center(
              child: CustomError(),
            ),
          ),
        ),
      ],
    );
  }
}
