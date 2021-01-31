import 'package:flutter_riverpod/all.dart';
import '../../enums/user_status_enum.dart';
import './../../management/authentication/user_status_provider.dart';
import './../user_service_provider.dart';

final userStatusFutureProvider = FutureProvider<UserStatus>((ref) async {
  UserStatus userStatus = ref.watch(userStatusStateProvider).state;
  return userStatus ??= await ref.watch(userServiceProvider).isLoggedIn;
});
