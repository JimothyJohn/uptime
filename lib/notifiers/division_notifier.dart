import 'package:flutter_riverpod/flutter_riverpod.dart';

class DivisionNotifier extends StateNotifier<String> {
  DivisionNotifier() : super('');

  void changeDivision(String newDivision) {
    state = newDivision;
  }
}

final divisionNotifierProvider =
    StateNotifierProvider<DivisionNotifier, String>((ref) {
  return DivisionNotifier();
});
