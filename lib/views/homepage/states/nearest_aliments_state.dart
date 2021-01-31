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
        (ref) => NearestAlimentsStateNotifier(ref));

class NearestAlimentsStateNotifier extends StateNotifier<List<NearestAliment>> {
  NearestAlimentsStateNotifier(this.ref) : super([]) {
    final homeRepo = ref.watch(homeRepositoryProvider);
    final userService = ref.watch(userServiceProvider);
    _searchTerms
        .debounceTime(const Duration(milliseconds: 800))
        .distinct()
        .asyncMap((search) async {
      final UserStorage user = await userService.currentUser;

      final List<NearestAliment> nearestAliments = await homeRepo
          .fetchNearestAliments(user.id, user.coordonnees, search);
      return nearestAliments;
    }).listen((na) {
      state = na;
    });
  }
  final ProviderReference ref;

  final BehaviorSubject<String> _searchTerms = BehaviorSubject<String>();

  Future<void> search(String aliment) async => _searchTerms.add(aliment);

  void close() => _searchTerms.close();
}
