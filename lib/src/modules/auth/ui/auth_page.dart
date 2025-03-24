import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/modular/go.dart';
import '../domain/bloc/auth_bloc.dart';
import '../domain/events/auth_event.dart';
import '../domain/states/auth_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.successAuthenticating) {
          Go.toReplacement('/home/');
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => context
                      .read<AuthBloc>()
                      .add(AuthEmailInputed(email: value)),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  onChanged: (value) => context
                      .read<AuthBloc>()
                      .add(AuthPasswordInputed(password: value)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthSubmitted());
                  },
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Implementar lógica de recuperação de senha
                    print('Esqueci a senha clicado');
                  },
                  child: const Text(
                    'Esqueci a senha',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
