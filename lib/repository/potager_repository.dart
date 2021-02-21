import 'package:flutter_riverpod/all.dart';
import './../management/dio/dio_provider.dart';
import './../models/potager_model.dart';

const String domain = 'http://localhost:9377';

class PotagerRepository {
  PotagerRepository(this._read);
  final Reader _read;

  Future<Potager> fetchPotager(int farmerId) async {
    final dynamic response = await _read(dioFullProvider)
        .get<dynamic>('$domain/f/fetch_potager/$farmerId');

    final Potager potager = Potager.fromJson(response.data);

    return potager;
  }
}
