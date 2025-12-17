import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../welcome/cubit/welcome_cubit.dart';
import '../../profile/cubit/number_cubit.dart';
import '../../injury/cubit/injury_cubit.dart';
import '../../assists/cubit/assists_cubit.dart';
import '../../points/cubit/points_cubit.dart';
import '../../settings/cubit/settings_cubit.dart';
import '../../nba/presentation/cubit/nba_cubit.dart';
import '../../../shared/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  setupServiceLocator(prefs);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WelcomeCubit()),
        BlocProvider(create: (context) => NumberCubit()),
        BlocProvider(create: (context) => InjuryCubit()),
        BlocProvider(create: (context) => AssistsCubit()),
        BlocProvider(create: (context) => PointsCubit()),
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(create: (context) => getIt<NbaCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Статистика баскетболиста',
            theme:           ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
              useMaterial3: true,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.grey,
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.orange,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: state.themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}

class PlayerProfileScreen extends StatefulWidget {
  const PlayerProfileScreen({super.key});

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  var avatarUrl = "https://static.vecteezy.com/system/resources/previews/027/573/570/non_2x/basketball-player-avatar-icon-on-white-background-vector.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Профиль игрока',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: avatarUrl,
                height: 200,
                width: 200,
                fit: BoxFit.fill,
                progressIndicatorBuilder:(context, url, progress)=>
                const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 100,
                  ),
                )
            ),
            BlocBuilder<WelcomeCubit, WelcomeState>(
              builder: (context, state) {
                final playerName = state.playerName.trim().isEmpty
                    ? 'Игрок не указан'
                    : state.playerName.trim();
                return Text(
                  playerName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Column(
                children: [
                  const Text(
                    'Статистика игрока',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Номер игрока:', style: TextStyle(fontSize: 18)),
                      BlocBuilder<NumberCubit, NumberState>(
                        builder: (context, state) {
                          return Text(
                            '${state.playerNumber}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Общие очки:', style: TextStyle(fontSize: 18)),
                      BlocBuilder<PointsCubit, PointsState>(
                        builder: (context, state) {
                          return Text(
                            '${state.totalPoints}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Ассисты:', style: TextStyle(fontSize: 18)),
                          BlocBuilder<AssistsCubit, AssistsState>(
                            builder: (context, state) {
                              return Text(
                                '${state.assists}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                              );
                            },
                          ),
                        ],
                      ),
                  const SizedBox(height: 15),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Статус:', style: TextStyle(fontSize: 18)),
                          BlocBuilder<InjuryCubit, InjuryState>(
                            builder: (context, state) {
                              return Text(
                                state.isInjured ? 'Травмирован' : 'Здоров',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                              );
                            },
                          ),
                        ],
                      ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(right: 10),
                         child: ElevatedButton(
                           onPressed: () async {
                             context.push(AppRouter.editProfileRoute);
                             setState(() {});
                           },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Редактировать профиль'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(AppRouter.settingsRoute);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.settings),
                              SizedBox(width: 8),
                              Text('Настройки'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRouter.statsRoute);
              break;
            case 1:
              context.go(AppRouter.injuryRoute);
              break;
            case 2:
              context.go(AppRouter.pointsRoute);
              break;
            case 3:
              context.go(AppRouter.assistsRoute);
              break;
            case 4:
              context.go(AppRouter.nbaRoute);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Травмы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball),
            label: 'Очки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake),
            label: 'Ассисты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label: 'API',
          ),
        ],
      ),
    );
  }
}
