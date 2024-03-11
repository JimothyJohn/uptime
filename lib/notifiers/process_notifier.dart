import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProcessNotifier extends StateNotifier<String> {
  ProcessNotifier() : super('');

  void changeProcess(String newProcess) {
    state = newProcess;
  }
}

final processNotifierProvider =
    StateNotifierProvider<ProcessNotifier, String>((ref) {
  return ProcessNotifier();
});
