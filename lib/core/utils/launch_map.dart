import 'package:ava/common/values/imports.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

void launchMapOnAndroid(LatLng location) async {
  try {
    const markerLabel = 'کلینیک دندانپزشکی';
    final url = Uri.parse(
      'geo:${location.latitude},${location.longitude}?q=${location.latitude},${location.longitude}($markerLabel)',
    );
    await launchUrl(url);
  } catch (error) {
    logger.e(error);
    AppToast.showError(
      title: 'خطا',
      description: 'اجرای نقشه با خطا مواجه شد. لطفا دوباره تلاش کنید.',
    );
  }
}

void launchMapOnIOS(LatLng location) async {
  try {
    final url = Uri.parse(
      'maps:${location.latitude},${location.longitude}?q=${location.latitude},${location.longitude}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch map $url';
    }
  } catch (error) {
    logger.e(error);
    AppToast.showError(
      title: 'خطا',
      description: 'اجرای نقشه با خطا مواجه شد. لطفا دوباره تلاش کنید.',
    );
  }
}

void launchMapOnWeb(LatLng location) async {
  try {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch map $url';
    }
  } catch (error) {
    logger.e(error);
    AppToast.showError(
      title: 'خطا',
      description: 'اجرای نقشه با خطا مواجه شد. لطفا دوباره تلاش کنید.',
    );
  }
}
