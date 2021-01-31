import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/all.dart';
import './../management/dialog/flushbar_state_notifier.dart';
import './../management/dio/dio_provider.dart';
import './../management/translation/translation_provider.dart';
import './../models/nearest_aliment_model.dart';
import './../models/nearest_potager_model.dart';

const String domain = 'http://localhost:9377';
const String nearestPotagersPath = '$domain/f/find_nearest_potagers';
const String nearestAlimentsPath = '$domain/f/find_nearest_aliments';

class HomepageRepository {
  HomepageRepository(this._read);
  final Reader _read;

  // gerer les erreurs
  Future<List<NearestPotager>> fetchNearestPotagers(
      List<double> coordonnees) async {
    if (coordonnees == null) {
      final Map<String, String> translate =
          _read(translationStateNotifierProvider.state);
      _read(messageStateProvider).state = translate['geo.not_found'];
      return [];
    }
    final String body = jsonEncode({'coordonnees': coordonnees});

    final dynamic response = await _read(dioFullProvider)
        .post<dynamic>(nearestPotagersPath, data: body);

    final List<NearestPotager> nearestPotagers =
        (response.data as List<dynamic>)
            .map((np) => NearestPotager.fromJson(np))
            .toList();

    return nearestPotagers;
  }

  Future<List<NearestAliment>> fetchNearestAliments(
      int userId, List<double> coordonnees, String search) async {
    if (coordonnees == null) {
      final Map<String, String> translate =
          _read(translationStateNotifierProvider.state);
      _read(messageStateProvider).state = translate['geo.not_found'];
      return [];
    }

    final String body =
        jsonEncode({'coordonnees': coordonnees, 'search': search});

    final dynamic response = await _read(dioFullProvider)
        .post<dynamic>(nearestAlimentsPath, data: body);

    final List<NearestAliment> nearestAliments =
        (response.data as List<dynamic>)
            .map((na) => NearestAliment.fromJson(na))
            .toList();

    return nearestAliments;
  }
}
