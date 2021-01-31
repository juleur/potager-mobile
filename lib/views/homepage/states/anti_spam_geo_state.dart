import 'package:flutter_riverpod/all.dart';
import './../../../management/dialog/flushbar_state_notifier.dart';
import './../../../management/translation/translation_provider.dart';

final antiSpamGeoStateNotifierProvider =
    StateNotifierProvider((ref) => AntiSpamGeoStateNotifier(ref.read));

class AntiSpamGeoStateNotifier extends StateNotifier<DateTime> {
  AntiSpamGeoStateNotifier(this._read) : super(null);
  final Reader _read;

  Future<bool> allowed() async {
    if (state == null) {
      state = DateTime.now().add(const Duration(minutes: 10));
      return Future.value(true);
    }

    final DateTime now = DateTime.now();
    if (state.isBefore(now)) {
      state = DateTime.now().add(const Duration(minutes: 10));
      return Future.value(true);
    }
    final Duration timeLeft = state.difference(now);
    final String msg = _read(translationStateNotifierProvider)
        .antiSpamMessage(_timeLeft(timeLeft));
    _read(messageStateProvider).state = msg;

    return Future.value(false);
  }

  String _timeLeft(Duration timeLeft) {
    final String value = timeLeft.toString();
    try {
      final int minute = int.parse(value.substring(2, 4));
      if (minute == 10) return minute.toString();
      return (minute + 1).toString();
    } on Exception {
      return 1.toString();
    }
  }
}
