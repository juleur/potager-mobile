import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import './../enums/user_status_enum.dart';
import './../models/tokens_model.dart';
import './../models/user_storage.dart';

class UserService {
  UserService(this._secureStorage);
  final FlutterSecureStorage _secureStorage;

  Future<UserStorage> get currentUser async {
    final String userJson = await _secureStorage.read(key: 'user');
    return UserStorage.fromJson(userJson);
  }

  Future<UserStatus> get isLoggedIn async {
    final UserStorage userStorage = await currentUser;
    if (userStorage.id == null ||
        userStorage.jwt == null ||
        userStorage.refreshToken == null) {
      return UserStatus.notloggedIn;
    }
    return UserStatus.loggedIn;
  }

  Future<void> addCommune(String newCommune) async {
    final UserStorage actualUser = await currentUser;
    final UserStorage newUser = UserStorage(
      id: actualUser.id,
      jwt: actualUser.jwt,
      refreshToken: actualUser.refreshToken,
      coordonnees: actualUser.coordonnees,
      commune: newCommune,
    );
    await _add(newUser);
  }

  Future<void> addCoordonnees(double lat, double long) async {
    final UserStorage actualUser = await currentUser;
    final UserStorage newUser = UserStorage(
      id: actualUser.id,
      jwt: actualUser.jwt,
      refreshToken: actualUser.refreshToken,
      coordonnees: [lat, long],
      commune: actualUser.commune,
    );
    await _add(newUser);
  }

  Future<void> updateTokens(Tokens tokens) async {
    final UserStorage actualUser = await currentUser;
    final UserStorage newUser = UserStorage(
      id: actualUser.id ?? _decodeUserId(tokens.jwt),
      jwt: tokens.jwt,
      refreshToken: tokens.refreshToken,
      coordonnees: actualUser.coordonnees,
      commune: actualUser.commune,
    );
    await _add(newUser);
  }

  Future<void> get delete async {
    await _secureStorage.delete(key: 'user');
  }

  Future<void> _add(UserStorage user) async {
    await _secureStorage.write(key: 'user', value: user.toJson());
  }

  int _decodeUserId(String jwt) {
    try {
      final Map<String, dynamic> payload = JwtDecoder.decode(jwt);
      return payload['userId'] as int;
    } on Exception {
      return 0;
    }
  }
}
