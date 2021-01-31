import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'language_storage_state_notifier.dart';

final languageStorageStateNotifierProvider =
    StateNotifierProvider((ref) => LanguageStorageStateNotifier(ref.read));
