import 'package:ava/common/values/imports.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

/// Example Usage:
/// ```dart
/// AppToast.showSuccess(
///   title: 'Title',
///   description: 'Description',
/// );
///
/// AppToast.showInfo(
///   title: 'Title',
///   description: 'Description',
/// );
///
/// AppToast.showWarning(
///   title: 'Title',
///   description: 'Description',
/// );
///
/// AppToast.showError(
///   title: 'Title',
///   description: 'Description',
/// );
/// ```
class AppToast {
  static void showInfo({
    required String title,
    String? description,
  }) {
    _show(
      type: ToastificationType.info,
      title: title,
      description: description,
    );
  }

  static void showSuccess({
    required String title,
    String? description,
  }) {
    _show(
      type: ToastificationType.success,
      title: title,
      description: description,
    );
  }

  static void showWarning({
    required String title,
    String? description,
  }) {
    _show(
      type: ToastificationType.warning,
      title: title,
      description: description,
    );
  }

  static void showError({
    required String title,
    String? description,
  }) {
    _show(
      type: ToastificationType.error,
      title: title,
      description: description,
    );
  }
}

void _show({
  required ToastificationType type,
  required String title,
  String? description,
}) {
  HapticFeedback.lightImpact();
  toastification.dismissAll();
  toastification.showWithNavigatorState(
    navigator: navigatorKey.currentState!,
    alignment: Alignment.topCenter,
    animationDuration: const Duration(milliseconds: 300),
    autoCloseDuration: const Duration(seconds: 3),
    builder: (context, item) {
      return _FadeDismissible(
        item: item,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: BuiltInToastBuilder(
            type: type,
            onCloseTap: () => toastification.dismiss(item),
            borderRadius: BorderRadius.circular(10.r),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            style: ToastificationStyle.flat,
            direction: TextDirection.rtl,
            boxShadow: lowModeShadow,
            showProgressBar: false,
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.onBackground,
            primaryColor: switch (type) {
              ToastificationType.info => AppColors.primary,
              ToastificationType.success => AppColors.green1,
              ToastificationType.warning => AppColors.amber,
              ToastificationType.error => AppColors.error,
            },
            title: Text(
              title,
              style: context.labelSmall.copyWith(
                color: AppColors.onBackground,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            description: description != null
                ? Text(
                    description,
                    style: context.bodySmall.copyWith(
                      color: AppColors.onBackground,
                      fontSize: 10.sp,
                    ),
                  )
                : null,
          ),
        ),
      );
    },
  );
}

class _FadeDismissible extends HookWidget {
  const _FadeDismissible({
    required this.item,
    required this.child,
  });

  final ToastificationItem item;
  final Widget child;

  void _handleDragUpdate(bool startDrag) {
    if (item.hasTimer && startDrag) {
      item.pause();
    } else {
      item.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentOpacity = useState(0.0);
    return Listener(
      onPointerDown: (event) {
        _handleDragUpdate(true);
      },
      onPointerUp: (event) {
        _handleDragUpdate(false);
      },
      child: Dismissible(
        key: ValueKey('dismiss-${item.id}'),
        onUpdate: (details) {
          currentOpacity.value = details.progress;
        },
        direction: DismissDirection.horizontal,
        behavior: HitTestBehavior.deferToChild,
        onDismissed: (direction) {
          toastification.dismiss(
            item,
            showRemoveAnimation: false,
          );
        },
        child: Opacity(
          opacity: 1 - currentOpacity.value,
          child: child,
        ),
      ),
    );
  }
}
