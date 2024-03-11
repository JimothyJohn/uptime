import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterPopoutNotifier extends StateNotifier<bool> {
  FilterPopoutNotifier() : super(false);

  void toggleFilterPopout() {
    state = !state;
  }
}

final filterPopoutNotifierProvider =
    StateNotifierProvider<FilterPopoutNotifier, bool>((ref) {
  return FilterPopoutNotifier();
});
