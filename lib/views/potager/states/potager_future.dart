import 'package:riverpod/all.dart';
import './../../../models/potager_model.dart';
import './../../../repository/potager_repository.dart';
import './../../../views/potager/states/potager_provider.dart';

final potagerFuture = FutureProvider.family<Potager, int>((ref, id) async {
  final PotagerRepository potagerRepo = ref.watch(potagerRepositoryProvider);
  return potagerRepo.fetchPotager(id);
});
