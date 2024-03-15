import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visuals/common/models.dart';
import 'package:visuals/common/utils.dart';
import 'package:visuals/notifiers/machine_notifier.dart';
import 'package:visuals/ui/speedometer.dart';
import 'package:visuals/ui/bar_chart.dart';
import 'package:visuals/ui/theme.dart';

class MachineDetailsPopup extends StatelessWidget {
  final Machine machine;
  final String timeUnit;
  const MachineDetailsPopup(
      {super.key, required this.machine, required this.timeUnit});

  @override
  Widget build(BuildContext context) {
    // Assuming MachineProvider is set up correctly
    // final Machine machine = ref.watch(machineNotifierProvider);
    return Dialog(
      child: SizedBox(
        // Set a specific height and width for the dialog if needed
        width: 400,
        height: 500,
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
                      AnalyticsTab(machine: machine, timeUnit: timeUnit),
                      EditMachineTab(machine: machine),
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
  final Machine machine;
  final String timeUnit;

  const AnalyticsTab({Key? key, required this.machine, required this.timeUnit})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(machine.name,
              style: textStyle.copyWith(
                  color: Theme.of(context).colorScheme.onSurface)),
          const Speedometer(
            size: 150,
            value: 0.82,
          ),
          // Assuming ProductivityBarChart and Speedometer accept a Machine object
          ProductivityBarChart(
            size: 300,
            measurements: normalizeMeasurements(machine,
                generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8)),
            timeUnit: timeUnit,
          ),
        ],
      ),
    );
  }
}

class EditMachineTab extends ConsumerWidget {
  final Machine machine;

  EditMachineTab({Key? key, required this.machine}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController =
        TextEditingController(text: machine.name);

    final TextEditingController hourlyValueController =
        TextEditingController(text: machine.hourlyValue.toString());
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: hourlyValueController,
              decoration: InputDecoration(labelText: 'Hourly Value'),
              keyboardType: TextInputType.number,
            ),
            // Add fields for other properties
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Assuming you have a method to update machine properties
                  ref.read(machineNotifierProvider.notifier).updateMachine(
                        machine.copyWith(
                          name: nameController.text,
                          hourlyValue:
                              double.tryParse(hourlyValueController.text),
                          // Include other updated properties
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
