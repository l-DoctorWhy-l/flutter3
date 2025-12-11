import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/stats/screens/main.dart';
import 'features/profile/screens/edit_profile_screen.dart';
import 'features/points/screens/points_screen.dart';
import 'features/assists/screens/assists_screen.dart';
import 'features/injury/screens/injury_screen.dart';
import 'features/welcome/screens/welcome_screen.dart';
import 'features/settings/screens/settings_screen.dart';

class AppRouter {
  static const String welcomeRoute = '/';
  static const String statsRoute = '/stats';
  static const String editProfileRoute = '/edit-profile';
  static const String pointsRoute = '/points';
  static const String assistsRoute = '/assists';
  static const String injuryRoute = '/injury';
  static const String settingsRoute = '/settings';

  static final GoRouter router = GoRouter(
    initialLocation: welcomeRoute,
    routes: [
      GoRoute(
        path: welcomeRoute,
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: statsRoute,
        name: 'stats',
        builder: (context, state) => const PlayerProfileScreen(),
      ),
      GoRoute(
        path: editProfileRoute,
        name: 'edit-profile',
        builder: (context, state) => const EditProfileScreen(),
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
      GoRoute(
        path: settingsRoute,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
