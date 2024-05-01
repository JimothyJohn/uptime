// timeUnit_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeUnitNotifier extends StateNotifier<String> {
  TimeUnitNotifier() : super('Shifts');

  void changeTimeUnit(String newTimeUnit) {
    state = newTimeUnit;
  }
}

final timeUnitNotifierProvider =
    StateNotifierProvider<TimeUnitNotifier, String>((ref) {
  return TimeUnitNotifier();
});
