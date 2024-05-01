import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:visuals/notifiers/theme_notifier.dart';
import 'package:visuals/common/theme.dart';
import 'package:visuals/ui/app_bar.dart';
import 'package:visuals/ui/trend_page.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the theme mode state
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
        title: 'Uptime Visualization',
        theme: lightTheme, // Defined in your theme.dart
        darkTheme: darkTheme, // Defined in your theme.dart
        themeMode: themeMode, // Use the theme mode from the state notifier
        home: Scaffold(
          appBar: MyAppBar(
            title: "UPTIME",
            themeMode: themeMode,
          ),
          body: const ListPage(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            foregroundColor: Theme.of(context).colorScheme.surface,
            onPressed: () => print("Hello"),
            tooltip: 'Add machine',
            child: const Icon(Icons.add),
          ),
        ));
  }
}
