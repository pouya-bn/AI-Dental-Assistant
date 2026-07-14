import 'package:ava/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:signalr_core/signalr_core.dart';

extension ApiClientExceptionX on ApiException {
  String? get responseMessage => response?.data?['message'] as String?;
}

extension StringX on String {
  bool get isValidPhone {
    var regex = RegExp(
      r'^09\d{9}$',
      caseSensitive: false,
    );
    return regex.hasMatch(this);
  }

  bool get isValidOtp {
    final regex = RegExp(r'^\d{5}$');
    return regex.hasMatch(this);
  }
}

extension FileSizeX on num {
  String get readable {
    const List<String> affixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];

    int round = 2;
    num divider = 1024;
    num size = this;
    num runningDivider = divider;
    num runningPreviousDivider = 0;
    int affix = 0;

    while (size >= runningDivider && affix < affixes.length - 1) {
      runningPreviousDivider = runningDivider;
      runningDivider *= divider;
      affix++;
    }

    String result =
        (runningPreviousDivider == 0 ? size : size / runningPreviousDivider)
            .toStringAsFixed(round);

    if (result.endsWith("0" * round)) {
      result = result.substring(0, result.length - round - 1);
    }

    return "$result ${affixes[affix]}";
  }
}

extension BuildContextX on BuildContext {
  /// Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// MediaQuery.of(context)
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// MediaQuery.of(context).size.height
  double get height => mediaQuery.size.height;

  /// MediaQuery.of(context).size.width
  double get width => mediaQuery.size.width;

  /// Directionality.of(context) == TextDirection.rtl
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  /// Theme.of(context).textTheme
  TextTheme get textTheme => theme.textTheme;

  TextStyle get headlineLarge => textTheme.headlineLarge!;

  TextStyle get headlineMedium => textTheme.headlineMedium!;

  TextStyle get headlineSmall => textTheme.headlineSmall!;

  TextStyle get titleLarge => textTheme.titleLarge!;

  TextStyle get titleMedium => textTheme.titleMedium!;

  TextStyle get titleSmall => textTheme.titleSmall!;

  TextStyle get labelLarge => textTheme.labelLarge!;

  TextStyle get labelMedium => textTheme.labelMedium!;

  TextStyle get labelSmall => textTheme.labelSmall!;

  TextStyle get bodyLarge => textTheme.bodyLarge!;

  TextStyle get bodyMedium => textTheme.bodyMedium!;

  TextStyle get bodySmall => textTheme.bodySmall!;
}

extension GlobalKeyX on GlobalKey {
  Rect? get bounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }

  Offset get center {
    final bounds = this.bounds;
    if (bounds != null) {
      return bounds.center;
    } else {
      return Offset.zero;
    }
  }

  double get dx => center.dx;

  double get dy => center.dy;
}

extension LogLevelToLevel on LogLevel {
  Level toLevel() {
    switch (this) {
      case LogLevel.trace:
        return Level.trace;
      case LogLevel.debug:
        return Level.debug;
      case LogLevel.information:
        return Level.info;
      case LogLevel.warning:
        return Level.warning;
      case LogLevel.error:
        return Level.error;
      case LogLevel.critical:
        return Level.fatal;
      case LogLevel.none:
        return Level.off;
      default:
        return Level.off;
    }
  }
}
