import 'package:riverpod/all.dart';
import './../../../repository/potager_repository.dart';

final potagerRepositoryProvider =
    Provider<PotagerRepository>((ref) => PotagerRepository(ref.read));
