import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptime/common/utils.dart';
import 'package:uptime/models/ModelProvider.dart';
import 'package:uptime/test/utils.dart';
import 'package:uptime/notifiers/device_notifier.dart';
import 'package:uptime/ui/speedometer.dart';
import 'package:uptime/ui/bar_chart.dart';
import 'package:uptime/common/theme.dart';

class DeviceDetailsPopup extends StatelessWidget {
  final Device device;
  final String timeUnit;
  const DeviceDetailsPopup(
      {super.key, required this.device, required this.timeUnit});

  @override
  Widget build(BuildContext context) {
    // Assuming DeviceProvider is set up correctly
    // final Device device = ref.watch(deviceNotifierProvider);
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          maxWidth: 400,
        ),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            body: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      AnalyticsTab(device: device, timeUnit: timeUnit),
                      EditDeviceTab(device: device),
                    ],
                  ),
                ),
                Material(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
                      Tab(icon: Icon(Icons.edit), text: 'Edit'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnalyticsTab extends ConsumerWidget {
  final Device device;
  final String timeUnit;

  const AnalyticsTab({super.key, required this.device, required this.timeUnit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(device.name,
              style: textStyle.copyWith(
                  color: Theme.of(context).colorScheme.onSurface)),
          const Speedometer(
            size: 150,
            value: 0.82,
          ),
          // Assuming ProductivityBarChart and Speedometer accept a Device object
          ProductivityBarChart(
            size: 300,
            measurements:
                normalizeMeasurements(device, generateMeasurements("s", 1)[0]),
            timeUnit: timeUnit,
          ),
        ],
      ),
    );
  }
}

class EditDeviceTab extends ConsumerWidget {
  final Device device;

  EditDeviceTab({super.key, required this.device});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController =
        TextEditingController(text: device.name);

    final TextEditingController hourlyValueController =
        TextEditingController(text: device.hourlyValue.toString());

    final TextEditingController cycleTimeController =
        TextEditingController(text: device.cycleTime.toString());

    final TextEditingController divisionController =
        TextEditingController(text: device.division ?? '');

    final TextEditingController locationController =
        TextEditingController(text: device.location ?? '');

    final TextEditingController manufacturerController =
        TextEditingController(text: device.manufacturer ?? '');

    final TextEditingController modelController =
        TextEditingController(text: device.model ?? '');

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Scrollbar(
          thickness: 8,
          radius: const Radius.circular(4),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: true,
              overscroll: true,
            ),
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 16.0), // Space for scrollbar
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      TextFormField(
                        controller: hourlyValueController,
                        decoration:
                            const InputDecoration(labelText: 'Hourly Value'),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true), // Allow decimals
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(
                              r'^\d*\.?\d*')), // Only allow numbers and decimal point
                        ],
                      ),
                      TextFormField(
                        controller: cycleTimeController,
                        decoration:
                            const InputDecoration(labelText: 'Cycle Time (s)'),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true), // Allow decimals
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(
                              r'^\d*\.?\d*')), // Only allow numbers and decimal point
                        ],
                      ),
                      TextFormField(
                        controller: divisionController,
                        decoration:
                            const InputDecoration(labelText: 'Division'),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      TextFormField(
                        controller: locationController,
                        decoration:
                            const InputDecoration(labelText: 'Location'),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      TextFormField(
                        controller: manufacturerController,
                        decoration:
                            const InputDecoration(labelText: 'Manufacturer'),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      TextFormField(
                        controller: modelController,
                        decoration: const InputDecoration(labelText: 'Model'),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      const SizedBox(
                          height: 20), // Add some spacing before the button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(deviceNotifierProvider.notifier)
                                .updateDevice(
                                  device.copyWith(
                                    name: nameController.text,
                                    hourlyValue:
                                        hourlyValueController.text.isEmpty
                                            ? null
                                            : double.tryParse(
                                                hourlyValueController.text),
                                    division: divisionController.text.isEmpty
                                        ? null
                                        : divisionController.text,
                                    location: locationController.text.isEmpty
                                        ? null
                                        : locationController.text,
                                    manufacturer:
                                        manufacturerController.text.isEmpty
                                            ? null
                                            : manufacturerController.text,
                                    model: modelController.text.isEmpty
                                        ? null
                                        : modelController.text,
                                  ),
                                );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Saved!'),
                                behavior: SnackBarBehavior.floating,
                                width: 100,
                                duration: const Duration(milliseconds: 2000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
