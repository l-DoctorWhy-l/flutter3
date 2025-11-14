import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  final String playerName;

  const AppState({
    super.key,
    required this.playerName,
    required super.child,
  });

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  static String getPlayerName(BuildContext context) {
    final appState = of(context);
    return appState?.playerName ?? 'Игрок не указан';
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return playerName != oldWidget.playerName;
  }
}

