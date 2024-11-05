import 'package:flutter/material.dart';
import 'package:uptime/common/theme.dart';
// import 'package:visuals/features/user/ui/user_page.dart';
// import 'package:visuals/features/machine/ui/machines_page.dart';
// import 'package:visuals/features/dev/ui/dev_page.dart';
import 'package:uptime/features/auth/utils.dart';
import 'package:uptime/screens/welcome_screen.dart';
import 'package:uptime/screens/trend_screen.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptime/notifiers/theme_notifier.dart';

// Application for Uptime app
class Uptime extends ConsumerWidget {
  const Uptime({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Add AWS Authenticator and API plugins
    configureAmplify();

    final ThemeMode themeMode =
        ref.watch(themeNotifierProvider); // Watch the current time unit

    return Authenticator(
        // View Sign-In or Sign-Up page
        authenticatorBuilder: myAuthenticatorBuilder,
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            // '/settings': (context) => const UserScreen(),
            '/devices': (context) => const ListPage(),
            // '/dev': (context) => DevPage(),
          },
          builder: Authenticator.builder(),
          title: 'Uptime',
          // Greyblue forground on an off-white background with dark text
          theme: lightTheme, // Defined in your theme.dart
          darkTheme: darkTheme, // Defined in your theme.dart
          themeMode: themeMode, // Use the theme mode from the state notifier
          home: const LandingPage(),
        ));
  }
}
