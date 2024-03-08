import 'package:flutter/material.dart';
import 'package:visuals/visuals/bar_chart.dart';
import 'package:visuals/visuals/dollars.dart';
import 'package:visuals/utils.dart';
import 'package:visuals/constants.dart';
import 'package:visuals/visuals/led.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                child: IndicatorLed(
                    // Get the state of the most recent measurement
                    status: normalizedProduction[production.length - 1].value >
                        machine.runCurrent * .2,
                    size: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 100,
                  child: Text(machine.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.orbitron(
                          color: Theme.of(context).colorScheme.onSurface,
                          shadows: [
                            const Shadow(
                              offset: Offset(
                                  0, 0), // Horizontal and vertical offset
                              blurRadius: 10, // How much the shadow is blurred
                              color: Color.fromRGBO(130, 200, 130,
                                  0.1), // Shadow color with opacity
                            )
                          ],
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 200,
                  child: ProductivityBarChart(
                    size: 200,
                    measurements: normalizedProduction,
                    timeUnit: timeUnit,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 150,
                  child: MoneyValueText(
                      hours: perfectDay.length / 5,
                      hourlyValue: 100,
                      uptime: getUptimeMeasurements(normalizedProduction)),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
              width: 580,
              child: Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Theme.of(context).colorScheme.onSurface)),
        ),
      ],
    );
  }
}

class MachineList extends StatelessWidget {
  MachineList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Machine> machines = [
      perfecto,
      downBoy,
    ];
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        // Assuming generateDayMeasurements returns a List<Measurement>
        return MachineRow(
          production: generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
          machine: machines[index], // Loop through machines list
          timeUnit: "day",
        );
      },
    );
  }
}
