import 'package:riverpod/all.dart';

final favoriteButtonStateProvider = StateProvider<bool>((ref) => null);

final favoriteButtonStateNotifierProvider = StateNotifierProvider.autoDispose
    .family<FavoriteButtonStateNotifier, bool>((ref, status) {
  final bool s = ref.watch(favoriteButtonStateProvider).state ?? status;
  return FavoriteButtonStateNotifier(s);
});

class FavoriteButtonStateNotifier extends StateNotifier<bool> {
  FavoriteButtonStateNotifier(bool status) : super(status);
}
