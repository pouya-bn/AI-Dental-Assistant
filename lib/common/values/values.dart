import 'package:ava/common/values/imports.dart';
import 'package:latlong2/latlong.dart';

class AppValues {
  static final appbarHeight = 40.h;
  static final navbarHeight = 70.h;
  static final iconButtonSize = 40.h;

  static final textfieldHeight = 46.h;

  static const otpResendWait = 180;

  static const defaultLocation = LatLng(35.72, 51.40);

  static bool get chatIntroSeen {
    final introBox = Hive.box<bool>(AppStrings.introBox);
    return introBox.get(AppStrings.chatIntroKey, defaultValue: false) ?? false;
  }
}
