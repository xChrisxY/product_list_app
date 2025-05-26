import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_list_app/screens/product_list_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => ProductListScreen()),
      );
    } catch (e) {
      print('Error al iniciar sesión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInAnonymously(context),
          child: const Text('Iniciar Sesión Anónima'),
        ),
      ),
    );
  }
}
