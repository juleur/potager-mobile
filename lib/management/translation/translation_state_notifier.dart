import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../enums/language_enum.dart';

class TranslationStateNotifier extends StateNotifier<Map<String, String>> {
  TranslationStateNotifier() : super(<String, String>{});

  Future<void> fetchLocale(String langAbbre) async {
    // vérifie si locale est dans la liste
    if (isLanguageExists(langAbbre)) {
      state = await _load(langAbbre);
    } else {
      state = await _load(Language.francais.languageCode);
    }
  }

  Future<Map<String, String>> _load(String locale) async {
    final String jsonString =
        await rootBundle.loadString('assets/l10n/$locale.json');
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;
    return jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String get verifiedMessage => state['messenger.not_verified'];

  String antiSpamMessage(String duration) {
    if (duration == '1') {
      return state['geo.antispam.one']
          .replaceFirst('{value}', duration.toString());
    }
    return state['geo.antispam.other']
        .replaceFirst('{value}', duration.toString());
  }
}
