import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/core/models/address_model.dart';
import 'package:ava/core/providers/basic_provider.dart';

Future<CityModel?> showCityPicker(
  BuildContext context, {
  required int provinceId,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (context.mounted) {
    return await AppBottomSheet.show<CityModel?>(
      context,
      title: 'شهر',
      initialSnap: 0.8,
      children: [
        _Cities(provinceId: provinceId),
      ],
    );
  }
  return null;
}

class _Cities extends HookConsumerWidget {
  const _Cities({
    required this.provinceId,
  });

  final int provinceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cities = ref.watch(cityProvider(provinceId: provinceId));
    final notifier = ref.watch(cityProvider(provinceId: provinceId).notifier);
    final controller = useTextEditingController();
    useDebouncedSearch(
      controller,
      onDebounce: (value) {
        if (value.isEmpty) {
          notifier.getAll();
        } else {
          notifier.search(value);
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
        cities.when(
          data: (cities) {
            if (cities.isEmpty) {
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
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return ListTile(
                    title: Text(city.name),
                    onTap: () {
                      context.pop(city);
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
