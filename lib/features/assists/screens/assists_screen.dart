import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../app_router.dart';
import '../models/assist_record.dart';
import '../cubit/assists_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AssistsScreen extends StatelessWidget {
  const AssistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AssistsScreenContent();
  }
}

class _AssistsScreenContent extends StatelessWidget {
  const _AssistsScreenContent();

  @override
  Widget build(BuildContext context) {
    final assistsImageUrl =
        "https://avatars.mds.yandex.net/i?id=e2bf16d1019f20b61450e2b46ce6c27ebaf5c102-5490649-images-thumbs&n=13";

    return BlocBuilder<AssistsCubit, AssistsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text(
              'Ассисты',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
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
                  progressIndicatorBuilder: (context, url, progress) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, color: Colors.red, size: 100),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                        '${state.assists}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
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
                    onPressed: () => context.read<AssistsCubit>().addAssist(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      '+1 ассист',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                          child: state.assistsHistory.isEmpty
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
                                  itemCount: state.assistsHistory.length,
                                  itemBuilder: (context, index) {
                                    AssistRecord record =
                                        state.assistsHistory[index];

                                    return GestureDetector(
                                      key: record.key,
                                      onTap: () => context
                                          .read<AssistsCubit>()
                                          .removeAssist(index),
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(
                                          bottom: 6,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          border: Border.all(
                                            color: Theme.of(context).colorScheme.outlineVariant,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                            onPressed: state.assistsHistory.isNotEmpty
                                ? () => context
                                      .read<AssistsCubit>()
                                      .removeLastAssist()
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Удалить последнюю запись',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
      },
    );
  }
}
