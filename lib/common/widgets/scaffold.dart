import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.title,
    this.titleText,
    this.appbarHeight,
    this.actions,
    this.canPop = true,
    this.background,
    this.footer,
    this.padding,
    this.hasDivider = true,
    this.resizeToAvoidBottomInset,
    this.textAlign,
    this.centerTitle = true,
    this.maxLines,
  });

  final Widget body;
  final Widget? title;
  final String? titleText;
  final double? appbarHeight;
  final List<Widget>? actions;
  final bool canPop;
  final Widget? background;
  final Widget? footer;
  final EdgeInsetsGeometry? padding;
  final bool hasDivider;
  final bool? resizeToAvoidBottomInset;
  final bool centerTitle;
  final TextAlign? textAlign;
  final int? maxLines;

  factory CustomScaffold.variant({
    required Widget body,
    Widget? title,
    String? titleText,
    double? appbarHeight,
    List<Widget>? actions,
    bool canPop = true,
    Widget? background,
    Widget? footer,
    EdgeInsetsGeometry? padding,
    bool? resizeToAvoidBottomInset,
    bool centerTitle = true,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    return CustomScaffold(
      title: title,
      titleText: titleText,
      appbarHeight: appbarHeight,
      actions: actions,
      canPop: canPop,
      background: background,
      footer: footer,
      padding: EdgeInsets.zero,
      hasDivider: false,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      centerTitle: centerTitle,
      textAlign: textAlign,
      maxLines: maxLines,
      body: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.blue9,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        background ?? const Background(),
        Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                CustomAppBar(
                  titleText: titleText,
                  title: title,
                  actions: actions,
                  height: appbarHeight,
                  canPop: canPop,
                  textAlign: textAlign,
                  centerTitle: centerTitle,
                  maxLines: maxLines,
                ),
                SizedBox(height: 10.h),
                if (hasDivider) const CustomDivider(),
                Expanded(
                  child: Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: body,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: footer,
        ),
      ],
    );
  }
}
