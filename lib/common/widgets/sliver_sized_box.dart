import 'package:ava/common/values/imports.dart';

class SliverSizedBox extends StatelessWidget {
  const SliverSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
