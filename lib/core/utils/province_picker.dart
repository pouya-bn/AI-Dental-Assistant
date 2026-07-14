import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/core/models/address_model.dart';
import 'package:ava/core/providers/basic_provider.dart';

Future<ProvinceModel?> showProvincePicker(
  BuildContext context, {
  required int countryId,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (context.mounted) {
    return await AppBottomSheet.show<ProvinceModel?>(
      context,
      title: 'استان',
      initialSnap: 0.8,
      children: [
        _Provinces(countryId: countryId),
      ],
    );
  }
  return null;
}

class _Provinces extends HookConsumerWidget {
  const _Provinces({
    required this.countryId,
  });

  final int countryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provinces = ref.watch(provinceProvider(countryId: countryId));
    final controller = useTextEditingController();
    useDebouncedSearch(
      controller,
      onDebounce: (value) {
        if (value.isEmpty) {
          ref.read(provinceProvider(countryId: countryId).notifier).getAll();
        } else {
          ref
              .read(provinceProvider(countryId: countryId).notifier)
              .search(value);
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
        provinces.when(
          data: (provinces) {
            if (provinces.isEmpty) {
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
                itemCount: provinces.length,
                itemBuilder: (context, index) {
                  final province = provinces[index];
                  return ListTile(
                    title: Text(province.name),
                    onTap: () {
                      context.pop(province);
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
