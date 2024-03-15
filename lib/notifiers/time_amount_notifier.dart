// timeUnit_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeAmountNotifier extends StateNotifier<int> {
  // Change the generic type to int
  TimeAmountNotifier()
      : super(1); // Initialize with 1 representing the first number

  void changeTimeUnit(int newTimeUnit) {
    // Change method parameter type to int
    state = newTimeUnit; // Assign the new timeUnit (number) to state
  }
}

// Update the provider to reflect the change in the notifier's generic type
final timeAmountNotifierProvider =
    StateNotifierProvider<TimeAmountNotifier, int>((ref) {
  return TimeAmountNotifier();
});
