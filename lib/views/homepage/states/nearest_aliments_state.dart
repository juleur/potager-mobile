import 'package:flutter_riverpod/all.dart';
import 'package:rxdart/rxdart.dart';
import '../../../management/user_service_provider.dart';
import './../../../models/nearest_aliment_model.dart';
import './../../../models/user_storage.dart';
import './../../../views/homepage/states/nearest_potagers_state.dart';

final nearestAlimentsFuture =
    FutureProvider.autoDispose<List<NearestAliment>>((ref) async {
  final List<NearestAliment> nearestAliments =
      ref.watch(nearestAlimentsStateNotifier.state);
  return nearestAliments;
});

final nearestAlimentsStateNotifier =
    StateNotifierProvider<NearestAlimentsStateNotifier>(
        (ref) => NearestAlimentsStateNotifier(ref.read));

class NearestAlimentsStateNotifier extends StateNotifier<List<NearestAliment>> {
  NearestAlimentsStateNotifier(this._read) : super([]) {
    final homeRepo = _read(homeRepositoryProvider);
    final userService = _read(userServiceProvider);
    _searchTerms
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .asyncMap((search) async {
      final UserStorage user = await userService.currentUser;

      final List<NearestAliment> nearestAliments = await homeRepo
          .fetchNearestAliments(user.id, user.coordonnees, search);

      return nearestAliments;
    }).listen((na) {
      if (_isStateChanged(na)) state = na;
    });
  }
  final Reader _read;

  final BehaviorSubject<String> _searchTerms = BehaviorSubject<String>();

  Future<void> search(String aliment) async => _searchTerms.add(aliment);

  void resetState() => state = [];

  void close() => _searchTerms.close();

  bool _isStateChanged(List<NearestAliment> nearestAliments) {
    if (state.length != nearestAliments.length) return true;
    for (var i = 0; nearestAliments.length > i; i++) {
      if (state[i].user.id != nearestAliments[i].user.id &&
          state[i].aliment.id != nearestAliments[i].aliment.id) return true;
    }
    return false;
  }
}
