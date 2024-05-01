import 'package:flutter/material.dart';
import 'package:visuals/ui/bar_chart.dart';
import 'package:visuals/ui/machine_popup.dart';
import 'package:visuals/ui/dollars.dart';
import 'package:visuals/notifiers/process_notifier.dart';
import 'package:visuals/common/utils.dart';
import 'package:visuals/ui/led.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/common/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MachineHeader extends StatelessWidget {
  const MachineHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle rowTextStyle = GoogleFonts.orbitron(
        color: Theme.of(context).colorScheme.onSurface,
        shadows: [
          const Shadow(
            offset: Offset(0, 0), // Horizontal and vertical offset
            blurRadius: 10, // How much the shadow is blurred
            color:
                Color.fromRGBO(130, 200, 130, 0.1), // Shadow color with opacity
          )
        ],
        fontWeight: FontWeight.bold);
    const double padding = 8;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              child: Icon(Icons.power_settings_new,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: SizedBox(
                  width: 100,
                  child: Text("Name",
                      textAlign: TextAlign.center, style: rowTextStyle)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: SizedBox(
                width: 200,
                child: Text("Production",
                    textAlign: TextAlign.center, style: rowTextStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: SizedBox(
                width: 100,
                child: Text("Value",
                    textAlign: TextAlign.center, style: rowTextStyle),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: 600,
            child: Divider(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          ),
        ),
      ],
    );
  }
}

class MachineRow extends StatelessWidget {
  final List<Measurement> production;
  final Machine machine;
  final String timeUnit;
  const MachineRow(
      {Key? key,
      required this.production,
      required this.machine,
      required this.timeUnit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Measurement> normalizedProduction =
        normalizeMeasurements(machine, production);

    const double height = 25;
    const double padding = 8;

    return Column(
      children: [
        TextButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MachineDetailsPopup(
                      machine: machine, timeUnit: timeUnit);
                }),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Status LED
                SizedBox(
                  width: 20,
                  height: height,
                  child: IndicatorLed(
                      // Get the state of the most recent measurement
                      status:
                          normalizedProduction[production.length - 1].value >
                              machine.runCurrent * .2,
                      size: 20),
                ),
                // Machine name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: SizedBox(
                    width: 100,
                    height: height,
                    child: Text(machine.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orbitron(
                            color: Theme.of(context).colorScheme.onSurface,
                            shadows: [
                              const Shadow(
                                offset: Offset(
                                    0, 0), // Horizontal and vertical offset
                                blurRadius:
                                    10, // How much the shadow is blurred
                                color: Color.fromRGBO(130, 200, 130,
                                    0.1), // Shadow color with opacity
                              )
                            ],
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                // Productivity chart
                Padding(
                  padding: const EdgeInsets.only(bottom: padding),
                  child: SizedBox(
                    width: 200,
                    height: height,
                    child: ProductivityBarChart(
                      size: 200,
                      measurements: normalizedProduction,
                      timeUnit: timeUnit,
                    ),
                  ),
                ),
                // Value text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: MoneyValueText(
                        hours: 8,
                        hourlyValue: machine.hourlyValue,
                        uptime: getUptimeMeasurements(normalizedProduction)),
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: 550,
            height: height,
            child: Divider(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          ),
        ),
      ],
    );
  }
}

class MachineList extends ConsumerWidget {
  final String timeUnit;
  final Map<Machine, List<Measurement>> machineMeasurementsMap;

  const MachineList({
    Key? key,
    required this.timeUnit,
    required this.machineMeasurementsMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterProcess = ref.watch(processNotifierProvider);
    // Filter machines based on the specified process, if any.
    final List<Machine> filteredMachines = filterProcess == ""
        ? machineMeasurementsMap.keys.toList()
        : machineMeasurementsMap.keys
            .where((machine) => machine.process == filterProcess)
            .toList();
    return ListView.builder(
      itemCount: filteredMachines.length,
      itemBuilder: (context, index) {
        Machine machine = filteredMachines[index];
        List<Measurement> measurements = machineMeasurementsMap[machine]!;

        return MachineRow(
          production: measurements,
          machine: machine,
          timeUnit: timeUnit,
        );
      },
    );
  }
}
