import 'package:potager/enums/potager_sort_menu_enum.dart';
import 'package:riverpod/all.dart';

final selectedButtonStateProvider =
    StateProvider<SelectedButton>((ref) => SelectedButton.tous);
