import 'package:ava/common/values/imports.dart';
import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

/// Example Usage:
/// ```dart
/// AppBottomSheet.show(
///   context,
///   title: 'Title',
///   children: [
///     Container(height: 30, color: AppColors.primary),
///     const SizedBox(height: 10),
///     Container(height: 30, color: AppColors.primary),
///     const SizedBox(height: 10),
///     Container(height: 30, color: AppColors.primary),
///   ],
/// );
/// ```
class AppBottomSheet {
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    TextStyle? titleStyle,
    double? padding,
    Color backgroundColor = AppColors.background,
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
    double? initialSnap,
    Widget? footer,
    required List<Widget> children,
  }) async {
    return await showSnappingBottomSheet<T?>(
      context,
      useRootNavigator: true,
      builder: (context) {
        return SnappingBottomSheetDialog(
          elevation: 5,
          cornerRadius: 20.r,
          avoidStatusBar: true,
          cornerRadiusOnFullscreen: 0,
          duration: const Duration(milliseconds: 500),
          snapSpec: SnapSpec(
            snap: true,
            initialSnap: initialSnap,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          scrollSpec: const ScrollSpec(
            overscroll: false,
            overscrollColor: Colors.transparent,
            physics: ClampingScrollPhysics(),
          ),
          color: backgroundColor,
          headerBuilder: (context, state) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 30.w, 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Notch(),
                  SizedBox(height: 20.h),
                  Material(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (title != null)
                          Text(
                            title,
                            textAlign: TextAlign.start,
                            style: titleStyle ?? context.titleMedium,
                          ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 30.h,
                            height: 30.h,
                            child: IconButton(
                              onPressed: context.pop,
                              padding: EdgeInsets.zero,
                              icon: CustomSvg(
                                'assets/images/svg/close_circle_outline.svg',
                                width: 24.h,
                                height: 24.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          builder: (context, state) {
            return Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(
                  left: padding ?? 30.w,
                  right: padding ?? 30.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: alignment,
                  children: children,
                ),
              ),
            );
          },
          footerBuilder: footer != null
              ? (context, state) => Material(
                    color: Colors.transparent,
                    child: footer,
                  )
              : null,
        );
      },
    );
  }
}

class Notch extends StatelessWidget {
  const Notch({
    super.key,
    this.color = AppColors.grey3,
    this.progress,
  });

  final Color color;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 4.h,
      decoration: ShapeDecoration(
        color: progress != null
            ? color.withOpacity(
                0.5 * (1 - _interval(0.7, 1.0, progress!)),
              )
            : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
    );
  }
}

double _interval(double lower, double upper, double progress) {
  assert(lower < upper);

  if (progress > upper) return 1.0;
  if (progress < lower) return 0.0;

  return ((progress - lower) / (upper - lower)).clamp(0.0, 1.0);
}
