import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/visuals/speedometer.dart';
import 'package:visuals/common/ui.dart';
import 'package:visuals/constants.dart';

class DayPage extends StatefulWidget {
  const DayPage({
    Key? key,
  }) : super(key: key);
  @override
  _DayPageState createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  // This flag indicates whether the fade effect should be visible
  bool _showFadeEffect = true;

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
    return Align(
      alignment: Alignment.centerRight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Speedometer(value: 0.8, size: 150),
                  Text("UPTIME",
                      textAlign: TextAlign.center, style: rowTextStyle),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Icon(Icons.power_settings_new,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                      width: 100,
                      child: Text("NAME",
                          textAlign: TextAlign.center, style: rowTextStyle)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 200,
                    child: Text("PRODUCTION",
                        textAlign: TextAlign.center, style: rowTextStyle),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 150,
                    child: Text("VALUE",
                        textAlign: TextAlign.center, style: rowTextStyle),
                  ),
                ),
              ],
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
            Expanded(
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  // Determine if the scroll position is at the bottom
                  final bool atBottom = notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent;

                  // Update the visibility of the fade effect based on the scroll position
                  if (_showFadeEffect != !atBottom) {
                    setState(() {
                      _showFadeEffect = !atBottom;
                    });
                  }

                  // Returning null (or false) to indicate the notification is not handled further
                  return false;
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          MachineRow(
                            production: generateDayMeasurements(
                                DateTime(2024, 3, 4, 8, 0, 0), 9),
                            machine: perfecto, // Loop through machines list
                            timeUnit: "day",
                          ),
                          MachineRow(
                            production: generateDayMeasurements(
                                DateTime(2024, 3, 4, 8, 0, 0), 9),
                            machine: downBoy, // Loop through machines list
                            timeUnit: "day",
                          ),
                          MachineRow(
                            production: generateDayMeasurements(
                                DateTime(2024, 3, 4, 8, 0, 0), 9),
                            machine: upMan, // Loop through machines list
                            timeUnit: "day",
                          ),
                          MachineRow(
                            production: generateDayMeasurements(
                                DateTime(2024, 3, 4, 8, 0, 0), 9),
                            machine: perfecto, // Loop through machines list
                            timeUnit: "day",
                          ),
                          MachineRow(
                            production: generateDayMeasurements(
                                DateTime(2024, 3, 4, 8, 0, 0), 9),
                            machine: downBoy, // Loop through machines list
                            timeUnit: "day",
                          ),
                          MachineRow(
                            production: generateDayMeasurements(
                                DateTime(2024, 3, 4, 8, 0, 0), 9),
                            machine: upMan, // Loop through machines list
                            timeUnit: "day",
                          ),
                        ],
                      ),
                    ),
                    if (_showFadeEffect)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100, // Height of the fade effect area
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .background, // Starting color
                                Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
