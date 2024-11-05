import 'package:flutter/material.dart';
import 'package:uptime/ui/bar_chart.dart';
import 'package:uptime/screens/device_screen.dart';
import 'package:uptime/ui/dollars.dart';
import 'package:uptime/notifiers/process_notifier.dart';
import 'package:uptime/common/utils.dart';
import 'package:uptime/ui/led.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uptime/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceHeader extends StatelessWidget {
  const DeviceHeader({
    super.key,
  });

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

class DeviceRow extends StatelessWidget {
  final List<Measurement> production;
  final Device device;
  final String timeUnit;
  const DeviceRow(
      {super.key,
      required this.production,
      required this.device,
      required this.timeUnit});

  @override
  Widget build(BuildContext context) {
    final List<Measurement> normalizedProduction =
        normalizeMeasurements(device, production);

    const double height = 25;
    const double padding = 8;

    return Column(
      children: [
        TextButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeviceDetailsPopup(device: device, timeUnit: timeUnit);
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
                              (device.runCurrent ?? 0) * .2,
                      size: 20),
                ),
                // Device name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: SizedBox(
                    width: 100,
                    height: height,
                    child: Center(
                      child: Text(device.name,
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
                ),
                // Productivity chart
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
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
                    child: Center(
                      child: MoneyValueText(
                          hours: 8,
                          hourlyValue: device.hourlyValue,
                          uptime: getUptimeMeasurements(normalizedProduction)),
                    ),
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

class DeviceList extends ConsumerWidget {
  final String timeUnit;
  final Map<Device, List<Measurement>> deviceMeasurementsMap;

  const DeviceList({
    super.key,
    required this.timeUnit,
    required this.deviceMeasurementsMap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterProcess = ref.watch(processNotifierProvider);
    // Filter devices based on the specified process, if any.
    final List<Device> filteredDevices = filterProcess == ""
        ? deviceMeasurementsMap.keys.toList()
        : deviceMeasurementsMap.keys
            .where((device) => device.process == filterProcess)
            .toList();
    return ListView.builder(
      itemCount: filteredDevices.length,
      itemBuilder: (context, index) {
        Device device = filteredDevices[index];
        List<Measurement> measurements = deviceMeasurementsMap[device]!;

        return DeviceRow(
          production: measurements,
          device: device,
          timeUnit: timeUnit,
        );
      },
    );
  }
}
