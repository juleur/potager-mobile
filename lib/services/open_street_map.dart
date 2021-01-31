import 'package:flutter_riverpod/all.dart';
import 'package:geolocator/geolocator.dart';
import './../management/dialog/flushbar_state_notifier.dart';
import './../management/dio/dio_provider.dart';
import './../management/dio/exception/geolocation_exception.dart';
import './../management/geolocaliton/geolocation_provider.dart';
import './../management/user_service_provider.dart';

class OpenStreetMapService {
  OpenStreetMapService(this._read);
  final Reader _read;

  Future<String> fetchCommuneByGeo(List<double> coordonnees) async {
    List<double> coord = coordonnees;
    if (coordonnees == null) {
      coord = await _findCoordonnees();
      await _read(userServiceProvider).addCoordonnees(coord[0], coord[1]);
    }

    ///// À RETIRER /////
    coord = [45.01529307528278, 1.911748066222551];

    final response = await _read(dioBlankProvider).get<dynamic>(
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${coord[0]}&lon=${coord[1]}');

    final String communeJson = response.data['address']['village'] as String ??
        response.data['address']['town'] as String ??
        response.data['address']['city'] as String;
    return communeJson;
  }

  Future<List<double>> _findCoordonnees() async {
    Position pos;
    try {
      pos = await _read(geoPermissionProvider).determinePosition();
      await _read(userServiceProvider)
          .addCoordonnees(pos.latitude, pos.longitude);
    } on GeolocationException catch (e) {
      _read(messageStateProvider).state = e.message;
    }
    return [pos.latitude, pos.longitude];
  }
}
