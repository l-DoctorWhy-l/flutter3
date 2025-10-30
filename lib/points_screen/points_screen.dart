import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../assist_screen/assists_screen.dart';
import '../injury_screen/injury_screen.dart';
import '../main_screen/main.dart';
import '../app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  var pointsImageUrl = "https://static.tildacdn.com/stor3065-3031-4638-b735-383834343364/16274927.png";

  void _addPoints(int points) {
    setState(() {
      PlayerData.totalPoints += points;
      PlayerData.pointsHistory.add(points);
    });
  }

  void _removeLastPoints() {
    if (PlayerData.pointsHistory.isNotEmpty) {
      setState(() {
        int lastPoints = PlayerData.pointsHistory.removeLast();
        PlayerData.totalPoints -= lastPoints;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Управление очками',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: pointsImageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
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
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Column(
                children: [
                  const Text(
                    'Общее количество очков',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${PlayerData.totalPoints}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(right: 5),
                    child: ElevatedButton(
                      onPressed: () => _addPoints(1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        '+1',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: ElevatedButton(
                      onPressed: () => _addPoints(2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        '+2',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 5),
                    child: ElevatedButton(
                      onPressed: () => _addPoints(3),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        '+3',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            
            // История очков с скроллом
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'История забитых очков',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (PlayerData.pointsHistory.isEmpty)
                              const Text(
                                'История пуста',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              )
                            else
                              Column(
                                children: PlayerData.pointsHistory.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  int points = entry.value;
                                  return Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 6),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Заброс ${index + 1}:',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '+$points очков',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: PlayerData.pointsHistory.isNotEmpty ? _removeLastPoints : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Удалить последнюю запись',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
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
