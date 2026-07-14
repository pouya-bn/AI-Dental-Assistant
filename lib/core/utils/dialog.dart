import 'dart:async';

import 'package:ava/common/values/imports.dart';

/// Example Usage:
/// ```dart
/// AppDialog.show(
///   context,
///   title: 'Title',
///   content: Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       Container(height: 30, color: AppColors.primary),
///       const SizedBox(height: 10),
///       Container(height: 30, color: AppColors.primary),
///       const SizedBox(height: 10),
///       Container(height: 30, color: AppColors.primary),
///     ],
///   ),
///   actions: [
///     TextButton(
///       onPressed: () {},
///       child: const Text('Cancel'),
///     ),
///     ElevatedButton(
///       onPressed: () {},
///       child: const Text('Done'),
///     ),
///   ],
/// );
/// ```
class AppDialog {
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    TextStyle? titleStyle,
    String? description,
    Widget? content,
    String? actionText,
    List<Widget>? actions,
  }) async {
    return await showDialog<T?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          contentPadding: EdgeInsets.all(16.sp),
          backgroundColor: AppColors.onBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          title: title != null
              ? Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: titleStyle ??
                      context.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                )
              : null,
          content: content ??
              (description != null
                  ? Text(
                      description,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      style: context.bodySmall.copyWith(
                        color: AppColors.background,
                      ),
                    )
                  : null),
          actions: actions != null && actions.isNotEmpty
              ? actions
              : actionText != null
                  ? [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.onBackground,
                          foregroundColor: AppColors.primary,
                        ),
                        child: Text(
                          'متوجه شدم',
                          style: context.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ]
                  : null,
        );
      },
    );
  }
}
