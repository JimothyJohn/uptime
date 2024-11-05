import 'package:flutter/material.dart';
import 'package:uptime/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptime/app_config.dart';

void main() async {
  await getConfig();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: Uptime()));
}
