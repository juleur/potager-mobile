import 'package:flutter_riverpod/all.dart';
import 'package:geolocator/geolocator.dart';
import './../management/dio/exception/geolocation_exception.dart';
import './../management/translation/translation_provider.dart';

class GeoPermissionService {
  GeoPermissionService(this._read);
  final Reader _read;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final Map<String, String> translate =
          _read(translationStateNotifierProvider.state);
      throw GeolocationException(translate['geo.disabled']);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      final Map<String, String> translate =
          _read(translationStateNotifierProvider.state);
      throw GeolocationException(translate['geo.denied_forever']);
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        final Map<String, String> translate =
            _read(translationStateNotifierProvider.state);
        throw GeolocationException(translate['geo.denied']);
      }
    }

    return Geolocator.getCurrentPosition();
  }
}
