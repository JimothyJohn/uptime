import 'package:flutter/material.dart';
import 'package:visuals/ui/theme.dart';
import 'package:visuals/notifiers/theme_notifier.dart';
import 'package:visuals/notifiers/view_notifier.dart';
import 'package:visuals/notifiers/process_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        Switch(
            inactiveTrackColor: Theme.of(context).colorScheme.surface,
            activeColor: Theme.of(context).colorScheme.onSurface,
            value: ref.watch(themeNotifierProvider) == ThemeMode.dark
                ? true
                : false,
            onChanged: (value) {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            }),
        Icon(
          themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TimeUnitDropdown extends ConsumerWidget {
  const TimeUnitDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeUnit =
        ref.watch(viewNotifierProvider); // Watch the current time unit

    return DropdownButton<String>(
      style: textStyle.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      value: timeUnit,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? newValue) {
        if (newValue != null) {
          ref.read(viewNotifierProvider.notifier).changeView(newValue);
        }
      },
      items: <String>[
        'Day',
        'Week',
        'Month',
        'Solo',
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
