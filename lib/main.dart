import 'package:flutter/material.dart';
import 'package:visuals/theme.dart';
import 'package:visuals/visuals/day.dart';
import 'package:visuals/visuals/week.dart';
import 'package:visuals/visuals/month.dart';
import 'package:visuals/visuals/theme_notifier.dart';
import 'package:visuals/visuals/view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  // Default to light theme
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the theme mode state
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
        title: 'Visualization Sandbox',
        theme: lightTheme, // Defined in your theme.dart
        darkTheme: darkTheme, // Defined in your theme.dart
        themeMode: themeMode, // Use the theme mode from the state notifier
        home: MyHomePage(
          title: 'UPTIME',
        ));
  }
}

class Money extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Money View'),
    );
  }
}

// Inside my_home_page.dart
class MyHomePage extends ConsumerWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedView = ref.watch(viewNotifierProvider);
    final themeMode =
        ref.watch(themeNotifierProvider); // Add this to watch the theme mode

    Widget _getCurrentView() {
      switch (_selectedView) {
        case 'Day':
          return const DayPage();
        case 'Week':
          return const WeekPage();
        case 'Month':
          return const MonthPage();
        // Add cases for 'Money', 'Haas', 'Okuma', 'Mazak', 'UR'
        default:
          return const DayPage(); // Default view
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          // Your existing widgets and actions...
          DropdownButton<String>(
            value: _selectedView,
            icon: const Icon(Icons.arrow_downward),
            onChanged: (String? newValue) {
              ref.read(viewNotifierProvider.notifier).changeView(newValue!);
            },
            items: <String>[
              'Day',
              'Week',
              'Month',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          IconButton(
            icon: Icon(themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              // Directly call toggleTheme on your ThemeNotifier without using setState
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: _getCurrentView(),
    );
  }
}
