import 'package:ava/common/values/imports.dart';

part 'colors.dart';

class AppTheme {
  static ThemeData get theme => _theme;

  static final _defaultTheme = ThemeData.light(
    useMaterial3: true,
  );

  static final _theme = _defaultTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.onBackground,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.onBackground,
        side: const BorderSide(
          color: AppColors.outlineVariant,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: _resolve(
        on: AppColors.primary,
        off: AppColors.background,
      ),
      trackOutlineColor: _resolve(
        on: Colors.transparent,
        off: AppColors.outlineVariant,
      ),
      thumbColor: _resolve(
        on: AppColors.onBackground,
        off: AppColors.onBackground,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: _resolve(
        on: AppColors.primary,
        off: AppColors.background,
      ),
      side: const BorderSide(
        color: AppColors.onBackground,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: _resolve(
        on: AppColors.primary,
        off: AppColors.onBackground,
      ),
    ),
    textTheme: TextTheme(
      /// ╔════════════════════════════════╗
      /// ║            Headline            ║
      /// ╚════════════════════════════════╝
      headlineLarge: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: _sp(22),
      ),
      headlineMedium: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: _sp(20),
      ),
      headlineSmall: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: _sp(18),
      ),

      /// ╔═════════════════════════════╗
      /// ║            Title            ║
      /// ╚═════════════════════════════╝
      titleLarge: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: _sp(22),
      ),
      titleMedium: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: _sp(20),
      ),
      titleSmall: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: _sp(18),
      ),

      /// ╔═════════════════════════════╗
      /// ║            Label            ║
      /// ╚═════════════════════════════╝
      labelLarge: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: _sp(16),
      ),
      labelMedium: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: _sp(14),
      ),
      labelSmall: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: _sp(12),
      ),

      /// ╔════════════════════════════╗
      /// ║            Body            ║
      /// ╚════════════════════════════╝
      bodyLarge: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: _sp(16),
      ),
      bodyMedium: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: _sp(14),
      ),
      bodySmall: TextStyle(
        color: AppColors.onBackground,
        fontFamily: 'Abar',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: _sp(12),
      ),
    ),
  );
}

WidgetStateProperty<Color> _resolve({
  required Color on,
  required Color off,
}) {
  return WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return on;
      }
      return off;
    },
  );
}

double _sp(double size) {
  final s = size.sp;
  if (s <= 0 || s.isNaN) {
    logger.e('Invalid font size: $s');
    return size;
  }
  return s;
}
