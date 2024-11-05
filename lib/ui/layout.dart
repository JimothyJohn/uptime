import 'package:flutter/material.dart';
import 'package:uptime/notifiers/theme_notifier.dart';
import 'package:uptime/ui/appbars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UptimeBanner extends StatelessWidget {
  const UptimeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Icon(
          Icons.monitor_heart,
          size: 50,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      // prebuilt sign up form from amplify_authenticator package
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          'Uptime',
          style: TextStyle(
              color: Theme.of(context).colorScheme.surface, fontSize: 24),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(
          'Production quantified',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
        ),
      ),
    ]);
  }
}

class UptimeScaffold extends ConsumerWidget {
  const UptimeScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      /*
        By default, the Column widget will allow its children to expand to their natural height, which can cause the layout to become unbounded vertically. This can lead to the error you're seeing, which complains that a RenderBox has not been assigned a size.
        To fix this issue, you can wrap the Column widget in a Scaffold, and set the resizeToAvoidBottomInset property of the Scaffold to false. This will prevent the Column widget from expanding to fill the entire screen.
      */
      resizeToAvoidBottomInset: false,
      appBar: TopAppBarWidget(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: child,
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}

class Backdrop extends StatelessWidget {
  const Backdrop({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add a slight off-white gradient to the background
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFDDDDDD),
          ],
        ),
      ),
      child: child,
    );
  }
}

class FormPinner extends StatelessWidget {
  const FormPinner({super.key, required this.child, required this.alignment});
  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: alignment,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: child,
            )));
  }
}
