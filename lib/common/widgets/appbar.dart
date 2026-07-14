import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/appbar_title.dart';
import 'package:ava/common/widgets/back_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleText,
    this.height,
    this.actions,
    this.canPop = true,
    this.centerTitle = true,
    this.textAlign,
    this.maxLines,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  final Widget? title;
  final String? titleText;
  final double? height;
  final List<Widget>? actions;
  final bool canPop;
  final bool centerTitle;
  final TextAlign? textAlign;
  final int? maxLines;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      height: height ?? AppValues.appbarHeight,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: AppBar(
        toolbarHeight: height ?? AppValues.appbarHeight,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leadingWidth: AppValues.iconButtonSize,
        titleSpacing: 10.w,
        automaticallyImplyLeading: false,
        leading: canPop
            ? const Center(
                child: CustomBackButton(),
              )
            : null,
        centerTitle: centerTitle,
        title: title ??
            (titleText != null
                ? AppBarTitle(
                    title: titleText!,
                    textAlign: textAlign,
                    maxLines: maxLines,
                  )
                : null),
        actions: actions,
      ),
    );
  }
}
