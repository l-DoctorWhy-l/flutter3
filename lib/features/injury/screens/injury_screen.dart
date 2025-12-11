import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../assists/screens/assists_screen.dart';
import '../../points/screens/points_screen.dart';
import '../../../app_router.dart';
import '../models/injury_record.dart';
import '../cubit/injury_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class InjuryScreen extends StatelessWidget {
  const InjuryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _InjuryScreenContent();
  }
}

class _InjuryScreenContent extends StatelessWidget {
  const _InjuryScreenContent();

  @override
  Widget build(BuildContext context) {
    final injuryImageUrl = "https://avatars.mds.yandex.net/i?id=31e9ea7f4e226d025f03783511cde631_l-5338433-images-thumbs&n=13";

    return BlocBuilder<InjuryCubit, InjuryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: const Text(
                'Статус травмы',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
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
                      progressIndicatorBuilder: (context, url, progress) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      const Center(
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
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                          state.isInjured ? 'Травмирован' : 'Здоров',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: state.isInjured ? Colors.red : Colors.green,
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
                      onPressed: () =>
                          context.read<InjuryCubit>().toggleInjuryStatus(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isInjured ? Colors.green : Colors
                            .red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        state.isInjured ? 'Восстановился' : 'Получил травму',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                          child: state.injuryHistory.isEmpty
                              ? Center(
                                child: Text(
                                  'История пуста',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              )
                                : ListView.builder(
                              itemCount: state.injuryHistory.length,
                              itemBuilder: (context, index) {
                                InjuryRecord record = state
                                    .injuryHistory[index];

                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 6),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Theme.of(context).colorScheme.outlineVariant),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
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
                                              color: record.isInjured ? Colors
                                                  .red : Colors.green,
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
                              onPressed: state.injuryHistory.isNotEmpty
                                  ? () =>
                                  context
                                      .read<InjuryCubit>()
                                      .removeLastInjuryRecord()
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Удалить последнюю запись',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
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
    );
  }
}
