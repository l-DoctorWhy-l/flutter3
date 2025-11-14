import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../app_router.dart';
import '../cubit/welcome_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _WelcomeScreenContent();
  }
}

class _WelcomeScreenContent extends StatefulWidget {
  const _WelcomeScreenContent();

  @override
  State<_WelcomeScreenContent> createState() => _WelcomeScreenContentState();
}

class _WelcomeScreenContentState extends State<_WelcomeScreenContent> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _navigateToMainScreen() {
    final cubit = context.read<WelcomeCubit>();
    cubit.validateAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeCubit, WelcomeState>(
      listener: (context, state) {
        if (state.isValidating && state.isValid) {
          context.go(AppRouter.profileRoute);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.orange[50],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: BlocBuilder<WelcomeCubit, WelcomeState>(
                  builder: (context, state) {
                    if (_nameController.text != state.playerName) {
                      _nameController.text = state.playerName;
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_basketball,
                          size: 120,
                          color: Colors.orange[700],
                        ),
                        const SizedBox(height: 40),
                        
                        Text(
                          'Добро пожаловать!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        
                        Text(
                          'Введите имя баскетболиста',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Имя баскетболиста',
                            hintText: 'Например: Кварталов Егор Алексеевич',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.orange[700]!,
                                width: 2,
                              ),
                            ),
                            errorText: state.errorMessage,
                          ),
                          style: const TextStyle(fontSize: 18),
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            context.read<WelcomeCubit>().updatePlayerName(value);
                          },
                          onFieldSubmitted: (_) => _navigateToMainScreen(),
                        ),
                        const SizedBox(height: 32),
                        
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: state.isValidating
                                ? null
                                : _navigateToMainScreen,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[700],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            child: state.isValidating
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Начать',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

