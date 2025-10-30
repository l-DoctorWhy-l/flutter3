import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../injury_screen/injury_record.dart';
import '../assist_screen/assist_record.dart';
import '../app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Статистика баскетболиста',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      routerConfig: AppRouter.router,
    );
  }
}

class PlayerData {
  static String playerName = 'Кварталов Егор Алексеевич';
  static int playerNumber = 22;
  static int totalPoints = 0;
  static int assists = 0;
  static bool isInjured = false;
  static List<int> pointsHistory = [];
  static List<InjuryRecord> injuryHistory = [];
  static List<AssistRecord> assistsHistory = [];
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
            Text(
              PlayerData.playerName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
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
                      Text(
                          '${PlayerData.playerNumber}',
                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Общие очки:', style: TextStyle(fontSize: 18)),
                      Text(
                          '${PlayerData.totalPoints}',
                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ассисты:', style: TextStyle(fontSize: 18)),
                      Text(
                          '${PlayerData.assists}',
                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Статус:', style: TextStyle(fontSize: 18)),
                      Text(
                          PlayerData.isInjured ? 'Травмирован' : 'Здоров',
                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)
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
                             context.push(AppRouter.numberRoute);
                             setState(() {});
                           },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Смена номера'),
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
              context.go(AppRouter.profileRoute);
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
        ],
      ),
    );
  }
}
