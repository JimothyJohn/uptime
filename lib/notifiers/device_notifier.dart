// Import necessary Flutter and Riverpod packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptime/models/ModelProvider.dart';

class DeviceNotifier extends StateNotifier<Device> {
  DeviceNotifier()
      : super(Device(
          id: "",
          serialNumber: "",
          hourlyValue: 0,
          cycleTime: 1,
          active: true,
          name: "Default",
          runCurrent: 0.1,
          idleCurrent: 0.0,
          targetUptime: 0.0,
        ));

  // Update the device's details
  void updateDevice(Device newDevice) {
    state = newDevice;
  }
}

// Define a provider for DeviceNotifier
final deviceNotifierProvider =
    StateNotifierProvider<DeviceNotifier, Device>((ref) {
  return DeviceNotifier();
});
