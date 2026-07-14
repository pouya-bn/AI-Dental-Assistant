import 'package:ava/common/values/imports.dart';
import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.radius,
    this.color,
  });

  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: radius ?? 14.sp,
      color: color,
    );
  }
}
