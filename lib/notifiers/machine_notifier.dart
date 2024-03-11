// Import necessary Flutter and Riverpod packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visuals/common/models.dart';

class MachineNotifier extends StateNotifier<Machine> {
  MachineNotifier()
      : super(const Machine(
          id: "",
          hourlyValue: 100,
          cycleTime: 10,
          active: true,
          name: "Default",
          runCurrent: 0.0,
          idleCurrent: 0.0,
          targetUptime: 0.0,
        ));

  // Update the machine's details
  void updateMachine(Machine newMachine) {
    state = newMachine;
  }
}

// Define a provider for MachineNotifier
final machineNotifierProvider =
    StateNotifierProvider<MachineNotifier, Machine>((ref) {
  return MachineNotifier();
});
