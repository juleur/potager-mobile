import 'package:flutter_riverpod/all.dart';
import '../../../management/user_service_provider.dart';
import './../../../models/nearest_potager_model.dart';
import './../../../models/user_storage.dart';
import './../../../repository/homepage_repository.dart';
import './../../../services/user_service.dart';

final homeRepositoryProvider =
    Provider<HomepageRepository>((ref) => HomepageRepository(ref.read));

final nearestPotagerFuture = FutureProvider<List<NearestPotager>>((ref) async {
  final UserService userService = ref.watch(userServiceProvider);
  final UserStorage userStorage = await userService.currentUser;
  final HomepageRepository homeRepo = ref.watch(homeRepositoryProvider);
  return homeRepo.fetchNearestPotagers(userStorage.coordonnees);
});
