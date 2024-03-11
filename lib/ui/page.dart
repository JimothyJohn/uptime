import 'package:flutter/material.dart';
import 'package:visuals/ui/common.dart';
import 'package:visuals/common/utils.dart';
import 'package:visuals/ui/speedometer.dart';
import 'package:visuals/ui/app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/notifiers/view_notifier.dart';
import 'package:visuals/notifiers/filter_popout_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visuals/common/models.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isMenuVisible = ref.watch(filterPopoutNotifierProvider);
    // This flag indicates whether the fade effect should be visible
    bool _showFadeEffect = true;
    final String timeUnit =
        ref.watch(viewNotifierProvider); // Watch the current time unit

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

    late Map<Machine, List<Measurement>> measurements;

    switch (timeUnit.toLowerCase()) {
      case 'day':
        measurements = dayMeasurementMap;
      case 'week':
        measurements = weekMeasurementMap;
      case 'month':
        measurements = monthMeasurementMap;
      case 'solo':
        measurements = dayMeasurementMap;
      default:
        return const ListPage(); // Default view
    }
    ;

    return Stack(
      children: [
        // Covering the entire screen with a GestureDetector to detect taps outside the menu
        GestureDetector(
          onTap: () {
            if (isMenuVisible) {
              ref
                  .read(filterPopoutNotifierProvider.notifier)
                  .toggleFilterPopout(); // Hide the menu if it's visible and the user taps outside
            }
          },
          behavior: HitTestBehavior
              .opaque, // Ensures the GestureDetector covers the whole screen
          child: Container(
            color: Colors
                .transparent, // Must be transparent to allow taps to pass through when the menu is hidden
          ),
        ),
        // Your main content here, wrapped in IgnorePointer to disable interactions when the menu is visible
        IgnorePointer(
          ignoring: isMenuVisible,
          child: Opacity(
              opacity: isMenuVisible ? 0.5 : 1.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 600,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Speedometer(value: 0.8, size: 150),
                                Text("OEE",
                                    textAlign: TextAlign.center,
                                    style: rowTextStyle),
                              ],
                            ),
                            Row(
                              children: [
                                const TimeUnitDropdown(),
                                IconButton(
                                  icon: const Icon(Icons.filter_list),
                                  onPressed: () => ref
                                      .read(
                                          filterPopoutNotifierProvider.notifier)
                                      .toggleFilterPopout(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                child: Text("Name",
                                    textAlign: TextAlign.center,
                                    style: rowTextStyle)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: 200,
                              child: Text("Production",
                                  textAlign: TextAlign.center,
                                  style: rowTextStyle),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: 150,
                              child: Text("Value",
                                  textAlign: TextAlign.center,
                                  style: rowTextStyle),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: 600,
                          child: Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.2)),
                        ),
                      ), // Prevents bottom overflow
                      Expanded(
                        // Tracks scroll position
                        child: NotificationListener(
                          onNotification: (ScrollNotification notification) {
                            // Determine if the scroll position is at the bottom
                            // final bool atBottom = notification.metrics.pixels >=notification.metrics.maxScrollExtent;

                            // Returning null (or false) to indicate the notification is not handled further
                            return false;
                          },
                          child: Stack(
                            children: [
                              MachineList(
                                  timeUnit: timeUnit.toString().toLowerCase(),
                                  machineMeasurementsMap: measurements),
                              if (_showFadeEffect)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height:
                                        100, // Height of the fade effect area
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
                      ),
                    ],
                  ),
                ),
              )),
        ),
        // The filter-sort menu
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          right: isMenuVisible
              ? 0
              : -250, // Adjust the value to fit the width of your menu
          top: 0,
          bottom: 0,
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: ProcessDropdown(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: DivisionDropdown(),
              ),
              Row(
                children: [
                  Text("Close",
                      style: GoogleFonts.orbitron(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => ref
                        .read(filterPopoutNotifierProvider.notifier)
                        .toggleFilterPopout(),
                  ),
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }
}
