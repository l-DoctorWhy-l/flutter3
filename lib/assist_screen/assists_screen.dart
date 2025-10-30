import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../injury_screen/injury_screen.dart';
import '../main_screen/main.dart';
import '../points_screen/points_screen.dart';
import '../app_router.dart';
import 'assist_record.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AssistsScreen extends StatefulWidget {
  const AssistsScreen({super.key});

  @override
  State<AssistsScreen> createState() => _AssistsScreenState();
}

class _AssistsScreenState extends State<AssistsScreen> {
  var assistsImageUrl = "https://avatars.mds.yandex.net/i?id=e2bf16d1019f20b61450e2b46ce6c27ebaf5c102-5490649-images-thumbs&n=13";

  void _addAssist() {
    setState(() {
      PlayerData.assists += 1;
      PlayerData.assistsHistory.add(
        AssistRecord(
          timestamp: DateTime.now(),
          key: ValueKey(DateTime.now().millisecondsSinceEpoch),
        ),
      );
    });
  }

  void _removeAssist(int index) {
    if (PlayerData.assistsHistory.isNotEmpty && index < PlayerData.assistsHistory.length) {
      setState(() {
        PlayerData.assistsHistory.removeAt(index);
        PlayerData.assists = PlayerData.assistsHistory.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Ассисты',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: assistsImageUrl,
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
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: Column(
                children: [
                  const Text(
                    'Количество ассистов',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${PlayerData.assists}',
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
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _addAssist,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  '+1 ассист',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'История ассистов',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    Expanded(
                      child: PlayerData.assistsHistory.isEmpty
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
                              itemCount: PlayerData.assistsHistory.length,
                              itemBuilder: (context, index) {
                                AssistRecord record = PlayerData.assistsHistory[index];

                                return GestureDetector(
                                  key: record.key,
                                  onTap: () => _removeAssist(index),
                                  child: Container(
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
                                              'Ассист ${index + 1}:',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Text(
                                              '+1 ассист',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
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
                                        const SizedBox(height: 2),
                                        const Text(
                                          'Нажмите для удаления',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
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
                        onPressed: PlayerData.assistsHistory.isNotEmpty 
                            ? () {
                                if (PlayerData.assistsHistory.isNotEmpty) {
                                  _removeAssist(PlayerData.assistsHistory.length - 1);
                                }
                              }
                            : null,
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
        currentIndex: 3,
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
