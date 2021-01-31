import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../enums/language_enum.dart';
import './../flutter_secure_storage_provider.dart';
import './language_storage_provider.dart';
import './translation_provider.dart';

final langueFutureProvider = FutureProvider<Language>((ref) async {
  final Language language =
      ref.watch(languageStorageStateNotifierProvider.state);

  await ref
      .watch(flutterSecureStorageProvider)
      .write(key: 'lang', value: language.languageCode);
  await ref
      .watch(translationStateNotifierProvider)
      .fetchLocale(language.languageCode);

  return Future.value(language);
});
