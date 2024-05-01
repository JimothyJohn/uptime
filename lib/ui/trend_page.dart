import 'package:flutter/material.dart';
import 'package:visuals/test/utils.dart';
import 'package:visuals/ui/common.dart';
import 'package:visuals/test/constants.dart';
import 'package:visuals/ui/speedometer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/notifiers/time_unit_notifier.dart';
import 'package:visuals/notifiers/time_amount_notifier.dart';
import 'package:visuals/notifiers/process_notifier.dart';
import 'package:visuals/notifiers/filter_popout_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visuals/common/models.dart';
import 'package:visuals/common/theme.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isMenuVisible = ref.watch(filterPopoutNotifierProvider);
    // This flag indicates whether the fade effect should be visible
    bool showFadeEffect = true;
    final String timeUnit =
        ref.watch(timeUnitNotifierProvider); // Watch the current time unit
    final int timeAmount =
        ref.watch(timeAmountNotifierProvider); // Watch the current time unit

    final Map<Machine, List<Measurement>> measurements =
        createMachinesHistoryMap(
            timeUnit.toLowerCase()[0], timeAmount, allMachines);

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
                  width: 500,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child:
                                            Speedometer(value: 0.8, size: 150)),
                                    Text("OEE",
                                        style: textStyle.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => ref
                                      .read(
                                          filterPopoutNotifierProvider.notifier)
                                      .toggleFilterPopout(),
                                  child: Row(
                                    children: [
                                      Text("Filter",
                                          style: textStyle.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface)),
                                      const Icon(Icons.filter_list),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Past",
                                        style: textStyle.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: TimeAmountDropdown(),
                                    ),
                                    const TimeUnitDropdown(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const MachineHeader(),
                      // Prevents bottom overflow
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
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: MachineList(
                                    timeUnit: timeUnit.toString().toLowerCase(),
                                    machineMeasurementsMap: measurements),
                              ),
                              if (showFadeEffect)
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
              TextButton(
                onPressed: () => ref
                    .read(filterPopoutNotifierProvider.notifier)
                    .toggleFilterPopout(),
                child: Row(
                  children: [
                    Text("Close",
                        style: GoogleFonts.orbitron(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold)),
                    const Icon(Icons.close),
                  ],
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}

class TimeAmountDropdown extends ConsumerWidget {
  const TimeAmountDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeAmount =
        ref.watch(timeAmountNotifierProvider); // Watch the current time unit

    return DropdownButton<int>(
      style: textStyle.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      value:
          timeAmount, // Ensure timeUnit is an int representing the selected number. You might need to adjust its declaration and handling.
      icon: const Icon(Icons.arrow_downward),
      onChanged: (int? newValue) {
        if (newValue != null) {
          ref.read(timeAmountNotifierProvider.notifier).changeTimeUnit(
              newValue); // You may need to adjust the changeView method to accept int or handle the conversion more appropriately
        }
      },
      items: List<int>.generate(
              12,
              (int index) =>
                  index + 1) // Generates a list of numbers from 1 to 12
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child:
              Text(value.toString()), // Convert number to string for displaying
        );
      }).toList(),
    );
  }
}

class TimeUnitDropdown extends ConsumerWidget {
  const TimeUnitDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeUnit =
        ref.watch(timeUnitNotifierProvider); // Watch the current time unit

    return DropdownButton<String>(
      style: textStyle.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      value: timeUnit,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      onChanged: (String? newValue) {
        if (newValue != null) {
          ref.read(timeUnitNotifierProvider.notifier).changeTimeUnit(newValue);
        }
      },
      items: <String>[
        'Shifts',
        'Weeks',
        'Months',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class ProcessDropdown extends ConsumerWidget {
  const ProcessDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String process =
        ref.watch(processNotifierProvider); // Watch the current time unit

    return Column(
      children: [
        Text("Process",
            style: textStyle.copyWith(
                color: Theme.of(context).colorScheme.onSurface)),
        DropdownButton<String>(
          style: textStyle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          value: process,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (String? newValue) {
            if (newValue != null) {
              ref
                  .read(processNotifierProvider.notifier)
                  .changeProcess(newValue);
            }
          },
          items: <String>[
            "",
            'Addition',
            'Subtraction',
            'Assembly',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class DivisionDropdown extends ConsumerWidget {
  const DivisionDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String process =
        ref.watch(processNotifierProvider); // Watch the current time unit

    return Column(
      children: [
        Text("Division",
            style: textStyle.copyWith(
                color: Theme.of(context).colorScheme.onSurface)),
        DropdownButton<String>(
          style: textStyle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          value: process,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (String? newValue) {
            if (newValue != null) {
              ref
                  .read(processNotifierProvider.notifier)
                  .changeProcess(newValue);
            }
          },
          items: <String>[
            "",
            'Addition',
            'Subtraction',
            'Assembly',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
