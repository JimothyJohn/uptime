import 'package:flutter/material.dart';
import 'package:uptime/common/utils.dart';
import 'package:uptime/notifiers/theme_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UptimeIcon extends StatelessWidget {
  const UptimeIcon(
      {super.key,
      required this.label,
      required this.icon,
      required this.route});

  final String label;
  final String route;
  final IconData icon;
  final bool active = false;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.onSurface;
    if (route == ModalRoute.of(context)?.settings.name) {
      color = Theme.of(context).colorScheme.surface;
    }

    return Column(children: <Widget>[
      IconButton(
          icon: Icon(
            icon,
            color: color,
            shadows: const [
              Shadow(
                blurRadius: 4.0,
                color: Color.fromARGB(64, 0, 0, 0),
                offset: Offset(4.0, 4.0),
              ),
            ],
          ),
          onPressed: () => navigateToPage(context, route)),
      Text(label,
          style: TextStyle(
              color: color,
              shadows: const [
                Shadow(
                  blurRadius: 4.0,
                  color: Color.fromARGB(64, 81, 48, 48),
                  offset: Offset(4.0, 4.0),
                ),
              ],
              fontSize: 8,
              fontWeight: FontWeight.bold))
    ]);
  }
}

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: FittedBox(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSurface,
                shadows: const [
                  Shadow(
                    blurRadius: 4.0,
                    color: Color.fromARGB(64, 16, 9, 9),
                    offset: Offset(4.0, 4.0),
                  ),
                ],
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        const Expanded(
          child: FittedBox(
            child: UptimeIcon(
                label: "FACTORY",
                icon: Icons.factory_outlined,
                route: "/devices"),
          ),
        ),
        const Expanded(
          child: FittedBox(
            child: UptimeIcon(
                label: "ADMIN", icon: Icons.donut_large, route: "/dev"),
          ),
        ),
      ],
    ));
  }
}

class TopAppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const TopAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return AppBar(
        // TODO Add Uptime logo as home button
        title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                child: Text('Uptime',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        shadows: const [
                          Shadow(
                            blurRadius: 4.0,
                            color: Color.fromARGB(64, 81, 48, 48),
                            offset: Offset(4.0, 4.0),
                          ),
                        ],
                        fontWeight: FontWeight.bold)),
                // Navigate to home
                onTap: () => navigateToPage(context, '/'))),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: <Widget>[
          Switch(
              inactiveTrackColor: Theme.of(context).colorScheme.surface,
              activeColor: Theme.of(context).colorScheme.onSurface,
              value: themeMode == ThemeMode.dark ? true : false,
              onChanged: (value) {
                ref.read(themeNotifierProvider.notifier).toggleTheme();
              }),
          Icon(
            themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const FittedBox(
            child: UptimeIcon(
                label: "SETTINGS", icon: Icons.settings, route: "/settings"),
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
