import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'shared/service_locator.dart'; // Import service locator
import 'features/nba/presentation/cubit/nba_cubit.dart'; // Import Cubit
import 'features/stats/screens/main.dart';
import 'features/profile/screens/edit_profile_screen.dart';
import 'features/points/screens/points_screen.dart';
import 'features/assists/screens/assists_screen.dart';
import 'features/injury/screens/injury_screen.dart';
import 'features/welcome/screens/welcome_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/nba/presentation/screens/nba_dashboard_screen.dart';
import 'features/nba/presentation/screens/team_details_screen.dart';
import 'features/nba/presentation/screens/player_details_screen.dart';

class AppRouter {
  static const String welcomeRoute = '/';
  static const String statsRoute = '/stats';
  static const String editProfileRoute = '/edit-profile';
  static const String pointsRoute = '/points';
  static const String assistsRoute = '/assists';
  static const String injuryRoute = '/injury';
  static const String settingsRoute = '/settings';
  static const String nbaRoute = '/nba';
  static const String teamDetailsRoute = 'team-details';
  static const String playerDetailsRoute = 'player-details';

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
      GoRoute(
        path: nbaRoute,
        name: 'nba',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<NbaCubit>(),
          child: const NbaDashboardScreen(),
        ),
        routes: [
          GoRoute(
            path: 'team/:name',
            name: teamDetailsRoute,
            builder: (context, state) {
              final teamName = state.pathParameters['name']!;
              return BlocProvider(
                create: (context) => getIt<NbaCubit>(),
                child: TeamDetailsScreen(teamName: teamName),
              );
            },
          ),
          GoRoute(
            path: 'player/:id',
            name: playerDetailsRoute,
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              final name = state.extra as String? ?? 'Player Details';
              return BlocProvider(
                create: (context) => getIt<NbaCubit>(),
                child: PlayerDetailsScreen(playerId: id, playerName: name),
              );
            },
          ),
        ],
      ),
    ],
  );
}
