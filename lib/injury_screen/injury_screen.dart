import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../assist_screen/assists_screen.dart';
import '../main_screen/main.dart';
import '../points_screen/points_screen.dart';
import '../app_router.dart';
import 'injury_record.dart';
import 'package:cached_network_image/cached_network_image.dart';

class InjuryScreen extends StatefulWidget {
  const InjuryScreen({super.key});

  @override
  State<InjuryScreen> createState() => _InjuryScreenState();
}

class _InjuryScreenState extends State<InjuryScreen> {
  var injuryImageUrl = "https://avatars.mds.yandex.net/i?id=31e9ea7f4e226d025f03783511cde631_l-5338433-images-thumbs&n=13";

  void _toggleInjuryStatus() {
    setState(() {
      PlayerData.isInjured = !PlayerData.isInjured;
        PlayerData.injuryHistory.add(
          InjuryRecord(
            isInjured: PlayerData.isInjured,
            timestamp: DateTime.now(),
          ),
        );
    });
  }

  void _removeLastInjuryRecord() {
    if (PlayerData.injuryHistory.isNotEmpty) {
      setState(() {
        PlayerData.injuryHistory.removeLast();
        if (PlayerData.injuryHistory.isNotEmpty) {
          PlayerData.isInjured = PlayerData.injuryHistory.last.isInjured;
        } else {
          PlayerData.isInjured = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Статус травмы',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: injuryImageUrl,
                height: 150,
                width: 150,
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
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: Column(
                children: [
                  const Text(
                    'Текущий статус',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    PlayerData.isInjured ? 'Травмирован' : 'Здоров',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: PlayerData.isInjured ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _toggleInjuryStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PlayerData.isInjured ? Colors.green : Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  PlayerData.isInjured ? 'Восстановился' : 'Получил травму',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),
            
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'История травм',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    Expanded(
                      child: PlayerData.injuryHistory.isEmpty
                          ? const Center(
                              child: Text(
                                'История пуста',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: PlayerData.injuryHistory.length,
                              itemBuilder: (context, index) {
                                InjuryRecord record = PlayerData.injuryHistory[index];
                                
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 6),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Запись ${index + 1}:',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            record.statusText,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: record.isInjured ? Colors.red : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Время: ${record.fullTimestamp}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: PlayerData.injuryHistory.isNotEmpty ? _removeLastInjuryRecord : null,
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
        currentIndex: 1,
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
