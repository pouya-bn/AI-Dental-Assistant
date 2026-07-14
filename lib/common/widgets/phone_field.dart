import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/textfield.dart';

class PhoneField extends HookWidget {
  const PhoneField({
    super.key,
    required this.phone,
    this.enabled,
  });

  final TextEditingController phone;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final hasFocus = useState(false);
    useEffect(() {
      focusNode.addListener(() {
        hasFocus.value = focusNode.hasFocus;
      });
      return null;
    }, const []);
    return CustomTextField(
      enabled: enabled,
      focusNode: focusNode,
      controller: phone,
      keyboardType: TextInputType.number,
      hintText: hasFocus.value ? 'مثال: 09123456789' : 'شماره موبایل',
      suffixIcon: hasFocus.value
          ? Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const CustomSvg(
                  'assets/images/svg/close_circle_outline.svg',
                ),
                onPressed: phone.clear,
              ),
            )
          : null,
      suffixIconConstraints: BoxConstraints(
        maxHeight: AppValues.textfieldHeight - 10.h,
        maxWidth: AppValues.textfieldHeight,
      ),
    );
  }
}
