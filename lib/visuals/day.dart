import 'package:flutter/material.dart';
import 'package:visuals/visuals/speedometer.dart';
import 'package:visuals/visuals/clock.dart';
import 'package:visuals/visuals/shift_bar.dart';
import 'package:visuals/utils.dart';
import 'package:visuals/visuals/led.dart';
import 'package:google_fonts/google_fonts.dart';

class DayPage extends StatefulWidget {
  const DayPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Speedometer(value: getUptime(perfectDay), size: 250),
            Text("Efficiency",
                style: GoogleFonts.orbitron(
                    color: Theme.of(context).colorScheme.onSurface,
                    shadows: [
                      const Shadow(
                        offset: Offset(0, 0), // Horizontal and vertical offset
                        blurRadius: 10, // How much the shadow is blurred
                        color: Color.fromRGBO(
                            130, 200, 130, 0.1), // Shadow color with opacity
                      )
                    ],
                    fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: IndicatorLed(status: false, size: 25),
                    ),
                    Column(
                      children: [
                        Clock(
                            size: 150,
                            machineStates: normalDay,
                            startingHour: 8.0),
                        Text("Shift",
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Hourly Trend",
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
                      ProductivityBarChart(
                        size: 300,
                        machineStates: normalDay,
                        startingHour: 8.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        /*
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      */
        ;
  }
}
