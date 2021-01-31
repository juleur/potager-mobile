import 'package:flutter_riverpod/all.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../management/user_service_provider.dart';
import './../models/user_storage.dart';

class MessengerService {
  MessengerService(this._read);
  final Reader _read;

  Future<bool> isVerified() async {
    final UserStorage userStorage =
        await _read(userServiceProvider).currentUser;
    final Map<String, dynamic> payload = JwtDecoder.decode(userStorage.jwt);
    final bool status = payload['status'] as bool;
    if (status) {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
