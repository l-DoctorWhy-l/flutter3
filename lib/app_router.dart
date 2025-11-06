import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main_screen/main.dart';
import 'number_screen/number_screen.dart';
import 'points_screen/points_screen.dart';
import 'assist_screen/assists_screen.dart';
import 'injury_screen/injury_screen.dart';
import 'welcome_screen/welcome_screen.dart';

class AppRouter {
  static const String welcomeRoute = '/';
  static const String profileRoute = '/profile';
  static const String numberRoute = '/number';
  static const String pointsRoute = '/points';
  static const String assistsRoute = '/assists';
  static const String injuryRoute = '/injury';

  static final GoRouter router = GoRouter(
    initialLocation: welcomeRoute,
    routes: [
      GoRoute(
        path: welcomeRoute,
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: profileRoute,
        name: 'profile',
        builder: (context, state) => const PlayerProfileScreen(),
      ),
      GoRoute(
        path: numberRoute,
        name: 'number',
        builder: (context, state) => const NumberScreen(),
      ),
      GoRoute(
        path: pointsRoute,
        name: 'points',
        builder: (context, state) => const PointsScreen(),
      ),
      GoRoute(
        path: assistsRoute,
        name: 'assists',
        builder: (context, state) => const AssistsScreen(),
      ),
      GoRoute(
        path: injuryRoute,
        name: 'injury',
        builder: (context, state) => const InjuryScreen(),
      ),
    ],
  );
}
