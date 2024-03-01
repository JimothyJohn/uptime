import 'package:flutter/material.dart';
import 'package:visuals/theme.dart';
import 'package:visuals/visuals/day.dart';
import 'package:visuals/visuals/week.dart';
import 'package:visuals/visuals/month.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default to light theme
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visualization Sandbox',
      theme: lightTheme, // Defined in your theme.dart
      darkTheme: darkTheme, // Defined in your theme.dart
      themeMode: _themeMode,
      home: MyHomePage(
        title: 'Uptime',
        toggleTheme: toggleTheme,
      ),
    );
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

class MyHomePage extends StatefulWidget {
  final String title;
  final Function(bool) toggleTheme;

  const MyHomePage({Key? key, required this.title, required this.toggleTheme})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkModeEnabled = false;
  String _selectedView = 'Day';

  Widget _getCurrentView() {
    switch (_selectedView) {
      case 'Day':
        return const DayPage();
      case 'Week':
        return const WeekPage();
      case 'Month':
        return const MonthPage(title: "Month");
      case 'Money':
        return Money();
      default:
        return const DayPage(); // Default view
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        actions: <Widget>[
          DropdownButton<String>(
            value: _selectedView,
            icon: const Icon(Icons.arrow_downward),
            onChanged: (String? newValue) {
              setState(() {
                _selectedView = newValue!;
              });
            },
            items: <String>['Day', 'Week', 'Month', 'Money']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface)),
              );
            }).toList(),
          ),
          IconButton(
            icon: Icon(isDarkModeEnabled ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                isDarkModeEnabled = !isDarkModeEnabled;
                widget.toggleTheme(isDarkModeEnabled);
              });
            },
          ),
        ],
      ),
      body: _getCurrentView(),
    );
  }
}
