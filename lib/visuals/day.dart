import 'package:flutter/material.dart';
import 'package:visuals/visuals/speedometer.dart';
import 'package:visuals/visuals/clock.dart';
import 'package:visuals/visuals/shift_bar.dart';
import 'package:visuals/visuals/dollars.dart';
import 'package:visuals/utils.dart';
import 'package:visuals/visuals/led.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/theme.dart';

class DayPage extends StatelessWidget {
  const DayPage({
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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                    width: 100,
                    child: Text("Name",
                        textAlign: TextAlign.center, style: rowTextStyle)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 30,
                  child: Text("Status",
                      textAlign: TextAlign.center, style: rowTextStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 80,
                  child: Text("Uptime",
                      textAlign: TextAlign.center, style: rowTextStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 200,
                  child: Text("Shift",
                      textAlign: TextAlign.center, style: rowTextStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 100,
                  child: Text("Production",
                      textAlign: TextAlign.center, style: rowTextStyle),
                ),
              ),
            ],
          ),
          const Expanded(
            child: SingleChildScrollView(
                child: Column(children: [
              MachineRow(production: perfectDay),
              MachineRow(production: normalDay),
              MachineRow(production: downDay),
              MachineRow(production: upDay),
              MachineRow(production: perfectDay),
              MachineRow(production: normalDay),
              MachineRow(production: downDay),
              MachineRow(production: upDay),
              MachineRow(production: perfectDay),
              MachineRow(production: normalDay),
              MachineRow(production: downDay),
              MachineRow(production: upDay),
            ])),
          )
        ],
      ),
    );
  }
}

class MachineRow extends StatelessWidget {
  final List<double> production;
  const MachineRow({Key? key, required this.production}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
              width: 620,
              child: Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Theme.of(context).colorScheme.onSurface)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 100,
                  child: Text("Need arg",
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
                  width: 30,
                  child: IndicatorLed(
                      status: getUptime(production) > .6, size: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 80,
                  child: Speedometer(value: getUptime(production), size: 80),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 200,
                  child: ProductivityBarChart(
                    size: 200,
                    machineStates: production,
                    startingHour: 8.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 100,
                  child: MoneyValueText(
                      hours: perfectDay.length / 5,
                      hourlyValue: 100,
                      uptime: getUptime(production)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
