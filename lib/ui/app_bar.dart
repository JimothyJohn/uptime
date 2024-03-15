import 'package:flutter/material.dart';
import 'package:visuals/ui/theme.dart';
import 'package:visuals/notifiers/theme_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final ThemeMode themeMode;

  const MyAppBar({Key? key, required this.title, required this.themeMode})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(
        title,
        style:
            textStyle.copyWith(letterSpacing: 1.5, fontWeight: FontWeight.bold),
      ),
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
