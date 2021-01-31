import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/all.dart';
import './../enums/language_enum.dart';

final localeProvider = Provider<LocaleService>((ref) {
  const flutterSecureStorage = FlutterSecureStorage();
  return LocaleService(flutterSecureStorage);
});

class LocaleService {
  LocaleService(this._secureStorage);
  final FlutterSecureStorage _secureStorage;

  Future<String> get locale async {
    return await _secureStorage.read(key: 'lang') ?? 'fr_FR';
  }

  Future<void> changeLocale(Language locale) async {
    if (isLanguageExists(locale.languageCode)) {
      await _secureStorage.write(key: 'lang', value: locale.languageCode);
    } else {
      await _secureStorage.write(
          key: 'lang', value: Language.francais.languageCode);
    }
  }
}
