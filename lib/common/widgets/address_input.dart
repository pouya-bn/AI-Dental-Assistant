import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/option_tile.dart';
import 'package:ava/common/widgets/textfield.dart';
import 'package:ava/core/models/address_model.dart';
import 'package:ava/core/providers/user_provider.dart';
import 'package:ava/core/utils/city_picker.dart';
import 'package:ava/core/utils/province_picker.dart';

class AddressInput extends HookConsumerWidget {
  const AddressInput({
    super.key,
    required this.address,
    required this.onChanged,
  });

  final AddressModel? address;
  final ValueChanged<AddressModel?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address_ = useState<AddressModel?>(address);
    final number = useTextEditingController(
      text: address?.number?.toString(),
    );
    final unit = useTextEditingController(
      text: address?.unit?.toString(),
    );
    final location = useTextEditingController(
      text: address?.address,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: OptionTile(
                hintText: 'استان*',
                titleSpacing: 8.h,
                titleStyle: context.labelMedium.copyWith(
                  color: AppColors.blue14,
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.blue14,
                ),
                value: address_.value?.province?.name,
                onTap: () async {
                  final result = await showProvincePicker(
                    context,
                    countryId: self.countryId ?? 1,
                  );
                  if (result != null) {
                    address_.value = address_.value?.copyWith(
                      province: result,
                      city: null,
                    );
                    onChanged(address_.value);
                  }
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: OptionTile(
                enabled: address_.value?.province != null,
                hintText: 'شهر*',
                titleSpacing: 8.h,
                titleStyle: context.labelMedium.copyWith(
                  color: AppColors.blue14,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: address_.value?.province != null
                      ? AppColors.blue14
                      : AppColors.outlineVariant,
                ),
                value: address_.value?.city?.name,
                onTap: () async {
                  final result = await showCityPicker(
                    context,
                    provinceId:
                        address_.value?.province?.id ?? self.provinceId ?? 1,
                  );
                  if (result != null) {
                    address_.value = address_.value?.copyWith(
                      city: result,
                    );
                    onChanged(address_.value);
                  }
                },
                onDisabledTap: () {
                  AppToast.showInfo(
                    title: 'لطفاً ابتدا استان را انتخاب کنید',
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          hintText: 'نشانی*',
          controller: location,
          height: 110.h,
          maxLines: 4,
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: number,
                hintText: 'پلاک*',
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomTextField(
                controller: unit,
                hintText: 'واحد*',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
