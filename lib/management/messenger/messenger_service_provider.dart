import 'package:riverpod/all.dart';
import '../../services/messenger_service.dart';

final messengerServiceProvider =
    Provider<MessengerService>((ref) => MessengerService(ref.read));
