import 'package:flutter_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../../management/geolocaliton/osm_provider.dart';
import '../../../management/user_service_provider.dart';
import '../../../models/user_storage.dart';

final communeStateNotifierProvider =
    StateNotifierProvider((ref) => CommuneStateNotifier(ref.read));

class CommuneStateNotifier extends StateNotifier<String> {
  CommuneStateNotifier(this._read) : super('?') {
    _read(userServiceProvider).currentUser.then((user) {
      if (user.coordonnees != null) {
        state = user.commune;
      }
    });
  }
  final Reader _read;

  Future<void> fetchCommuneName() async {
    final UserStorage userStorage =
        await _read(userServiceProvider).currentUser;

    final String newCommune = await _read(osmServiceProvider)
        .fetchCommuneByGeo(userStorage.coordonnees);

    await _read(userServiceProvider).addCommune(newCommune);
  }
}
