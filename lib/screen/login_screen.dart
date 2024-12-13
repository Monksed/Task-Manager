import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import 'package:fbase/cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Вход'),
        backgroundColor: Colors.cyanAccent,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            GoRouter.of(context).go('/task');
          } else if (state is Unauthenticated && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: IntrinsicWidth(
                stepWidth: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Task Manager',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                    ),
                    const SizedBox(height: 60),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Пароль',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                        backgroundColor: Colors.cyanAccent,
                      ),
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              context.read<AuthCubit>().login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                            },
                      child: state is AuthLoading
                          ? const CircularProgressIndicator()
                          : const Text('Войти'),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => GoRouter.of(context).go('/register'),
                      child: const Text('Регистрация'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}