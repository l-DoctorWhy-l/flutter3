import 'package:flutter/material.dart';
import 'points_screen.dart';
import 'number_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Статистика баскетболиста',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const PlayerProfileScreen(),
    );
  }
}

class PlayerData {
  static String playerName = 'Кварталов Егор Алексеевич';
  static int playerNumber = 22;
  static int totalPoints = 0;
  static int assists = 0;
  static bool isInjured = false;
}

class PlayerProfileScreen extends StatefulWidget {
  const PlayerProfileScreen({super.key});

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
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
                             await Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => const PointsScreen()),
                             );
                             setState(() {});
                           },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Управление очками'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(left: 10),
                         child: ElevatedButton(
                           onPressed: () async {
                             await Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => const NumberScreen()),
                             );
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Навигация на экран ассистов
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Ассисты'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Навигация на экран травмы
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Статус травмы'),
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
    );
  }
}
