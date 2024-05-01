// Import necessary Flutter and Riverpod packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visuals/common/models.dart';
import 'package:visuals/test/constants.dart';

class MachineListNotifier extends StateNotifier<List<Machine>> {
  MachineListNotifier()
      : super([
          perfecto,
          downBoy,
          upMan,
          upMon,
        ]);

  // Add a new machine to the list
  void addMachine(Machine newMachine) {
    state = [...state, newMachine];
  }

  // Remove a machine from the list
  void removeMachine(Machine machineToRemove) {
    state = state.where((machine) => machine != machineToRemove).toList();
  }

  // Update a machine's details
  void updateMachine(Machine oldMachine, Machine updatedMachine) {
    state = state
        .map((machine) => machine == oldMachine ? updatedMachine : machine)
        .toList();
  }
}

// Define a provider for MachineListNotifier
final machineListNotifierProvider =
    StateNotifierProvider<MachineListNotifier, List<Machine>>((ref) {
  return MachineListNotifier();
});
