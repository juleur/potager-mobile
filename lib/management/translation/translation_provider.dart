import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'translation_state_notifier.dart';

final translationStateNotifierProvider =
    StateNotifierProvider((ref) => TranslationStateNotifier());
