import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/number_cubit.dart';
import '../../welcome/cubit/welcome_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EditProfileScreenContent();
  }
}

class _EditProfileScreenContent extends StatefulWidget {
  const _EditProfileScreenContent();

  @override
  State<_EditProfileScreenContent> createState() => _EditProfileScreenContentState();
}

class _EditProfileScreenContentState extends State<_EditProfileScreenContent> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final welcomeState = context.read<WelcomeCubit>().state;
    _nameController = TextEditingController(text: welcomeState.playerName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _changeNumber(BuildContext context, int change) {
    context.read<NumberCubit>().changeNumber(change);
  }

  @override
  Widget build(BuildContext context) {
    final numberImageUrl = "https://avatars.mds.yandex.net/i?id=1763b658ec69055baf20834e72398de1_l-5268818-images-thumbs&n=13";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Редактирование профиля',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Назад',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CachedNetworkImage(
                imageUrl: numberImageUrl,
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
            const SizedBox(height: 20),
            BlocBuilder<WelcomeCubit, WelcomeState>(
              builder: (context, state) {
                if (_nameController.text != state.playerName) {
                  _nameController.text = state.playerName;
                }
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.orange, width: 3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Имя игрока',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Имя баскетболиста',
                          hintText: 'Введите имя',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          errorText: state.errorMessage,
                        ),
                        style: const TextStyle(fontSize: 18),
                        textCapitalization: TextCapitalization.words,
                        onChanged: (value) {
                          context.read<WelcomeCubit>().updatePlayerName(value);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<NumberCubit, NumberState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Номер игрока',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${state.playerNumber}',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 70,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () => _changeNumber(context, 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      '+1',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () => _changeNumber(context, -1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      '-1',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
