// Import necessary Flutter and Riverpod packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptime/models/ModelProvider.dart';
import 'package:uptime/test/constants.dart';

class DeviceListNotifier extends StateNotifier<List<Device>> {
  DeviceListNotifier()
      : super([
          perfecto,
          downBoy,
          upMan,
          upMon,
        ]);

  // Add a new device to the list
  void addDevice(Device newDevice) {
    state = [...state, newDevice];
  }

  // Remove a device from the list
  void removeDevice(Device deviceToRemove) {
    state = state.where((device) => device != deviceToRemove).toList();
  }

  // Update a device's details
  void updateDevice(Device oldDevice, Device updatedDevice) {
    state = state
        .map((device) => device == oldDevice ? updatedDevice : device)
        .toList();
  }
}

// Define a provider for DeviceListNotifier
final deviceListNotifierProvider =
    StateNotifierProvider<DeviceListNotifier, List<Device>>((ref) {
  return DeviceListNotifier();
});
