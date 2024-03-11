import 'package:flutter/material.dart';
import 'package:visuals/ui/theme.dart';
import 'package:visuals/ui/page.dart';
import 'package:visuals/ui/app_bar.dart';
import 'package:visuals/notifiers/theme_notifier.dart';
import 'package:visuals/notifiers/view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the theme mode state
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
        title: 'Visualization Sandbox',
        theme: lightTheme, // Defined in your theme.dart
        darkTheme: darkTheme, // Defined in your theme.dart
        themeMode: themeMode, // Use the theme mode from the state notifier
        home: const MyHomePage(
          title: 'UPTIME',
        ));
  }
}

class MyHomePage extends ConsumerWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedView = ref.watch(viewNotifierProvider);

    Widget getCurrentView() {
      switch (selectedView) {
        case 'Day':
          return const ListPage();
        case 'Week':
          return const ListPage();
        case 'Month':
          return const ListPage();
        case 'Solo':
          return const ListPage();
        default:
          return const ListPage(); // Default view
      }
    }

    return Scaffold(
      appBar: MyAppBar(title: title),
      body: getCurrentView(),
    );
  }
}
