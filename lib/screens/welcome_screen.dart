import 'package:flutter/material.dart';
import 'package:uptime/ui/layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:uptimedev/features/user/utils.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UptimeScaffold(
        child: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.monitor_heart,
            size: 50,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Text(
            'Welcome to Uptime',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 24),
          ),
          Text('Production quantified',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    ));
  }
}

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // initalizeUser(ref);
    return const WelcomeScreen();
  }
}
