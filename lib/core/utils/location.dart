import 'package:ava/common/values/imports.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getSelfLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    AppToast.showError(
        title: 'سرویس موقعیت یاب (GPS) غیرفعال است',
        description: 'لطفا سرویس موقعیت یاب (GPS) دستگاه را فعال کنید');
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      AppToast.showError(
          title: 'مجوز دسترسی به موقعیت دستگاه وجود ندارد',
          description: 'لطفا به اپلیکیشن مجوز دسترسی به موقعیت بدهید');
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    AppToast.showError(
        title: 'مجوز دسترسی به موقعیت دستگاه وجود ندارد',
        description:
            'لطفا از تنظیمات دستگاه به اپلیکیشن مجوز دسترسی به موقعیت بدهید');
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
