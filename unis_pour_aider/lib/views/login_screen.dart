import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _authController = AuthController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset('assets/images/background.jpg', fit: BoxFit.cover)),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A92A5), Color(0xFF56C5D0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Connexion'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset('assets/images/logo.jpg', height: 80),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'Connexion',
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}