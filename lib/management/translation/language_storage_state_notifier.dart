import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../enums/language_enum.dart';
import './../flutter_secure_storage_provider.dart';

class LanguageStorageStateNotifier extends StateNotifier<Language> {
  LanguageStorageStateNotifier(this._read) : super(Language.francais) {
    _findLocale.then(updateLanguage);
  }
  final Reader _read;

  Future<Language> get _findLocale async {
    final String langAbbre =
        await _read(flutterSecureStorageProvider).read(key: 'lang');
    if (langAbbre == null) {
      state = Language.francais;
      return Future.value(Language.francais);
    }
    final Language language = findLanguage(langAbbre);
    state = language;
    return Future.value(language);
  }

  void updateLanguage(Language language) => state = language;
}
