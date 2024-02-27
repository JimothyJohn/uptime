import 'package:flutter/material.dart';
import 'package:visuals/visuals/speedometer.dart';
import 'package:visuals/visuals/week_chart.dart';
import 'package:visuals/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekPage extends StatefulWidget {
  const WeekPage({Key? key}) : super(key: key);

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Speedometer(value: getUptime(dayValues), size: 250),
                      Text("Efficiency",
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Weekly Productivity",
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
                      WeekView(
                          weekValues: const [0, 0.95, 0.7, 0.3, 0.6, 0.4, 0],
                          width: 300),
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
