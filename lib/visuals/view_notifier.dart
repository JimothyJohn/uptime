// view_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewNotifier extends StateNotifier<String> {
  ViewNotifier() : super('Day');

  void changeView(String newView) {
    state = newView;
  }
}

final viewNotifierProvider = StateNotifierProvider<ViewNotifier, String>((ref) {
  return ViewNotifier();
});
