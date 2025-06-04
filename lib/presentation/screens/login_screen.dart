import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthService authService = AuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Inicio de sesión",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),

                    const SizedBox(height: 10),

                    _CustomTextField(
                      controller: _usernameController,
                      hintText: 'username',
                    ),

                    const SizedBox(height: 10),

                    _CustomTextField(
                      controller: _passwordController,
                      hintText: 'password',
                    ),

                    const SizedBox(height: 10),

                    CustomElevatedButton(
                      usernameController: _usernameController,
                      passwordController: _passwordController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.login),
              label: Text("Iniciar sesión con Google"),
              onPressed: () async {
                final user = await authService.signInWithGoogle();
                if (user != null) {
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const _CustomTextField({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      controller: controller,
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const CustomElevatedButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return ElevatedButton(
      onPressed: () async {
        final username = usernameController.text;
        final password = passwordController.text;

        final user = await authService.loginWithEmailAndPassword(
          username,
          password,
        );

        if (user != null) {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
          );
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciales inválidas')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text('Iniciar Sesión'),
    );
  }
}
