import 'package:ava/common/theme/theme.dart';
import 'package:flutter/cupertino.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    this.isSwitched,
    this.onChanged,
  });

  final bool? isSwitched;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: isSwitched ?? false,
      onChanged: onChanged,
      activeColor: AppColors.green1,
      trackColor: AppColors.grey1,
    );
  }
}
