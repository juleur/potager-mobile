import 'package:flutter_riverpod/all.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/user_service.dart';
import 'flutter_secure_storage_provider.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final FlutterSecureStorage secureStorage =
      ref.watch(flutterSecureStorageProvider);
  return UserService(secureStorage);
});
