import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/session_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  Future<void> handleLogin() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _message = 'Veuillez remplir tous les champs.';
        _isLoading = false;
      });
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = credential.user;
      final token = await user?.getIdToken();

      print("Résultat : ${credential.user?.email}"); // Log email
      print("Token : $token");

      if (user != null && token != null) {
        final userData = {
          'uid': user.uid,
          'email': user.email ?? '',
          'displayName': user.displayName ?? '',
        };

        await SessionManager.saveUser(userData, token);
        _emailController.clear();
        _passwordController.clear();
        Navigator.pushReplacementNamed(context, '/map');
      } else {
        setState(() {
          _message = 'Identifiants invalides.';
        });
      }
    } on FirebaseAuthException catch (e) {
      print("Résultat : ${e.code} - ${e.message}");
      String errorMessage = e.message ?? 'Erreur inconnue';
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'Identifiants invalides ou expirés.';
          break;
        case 'user-not-found':
          errorMessage = 'Aucun compte trouvé avec cet email.';
          break;
        case 'wrong-password':
          errorMessage = 'Mot de passe incorrect.';
          break;
        case 'invalid-email':
          errorMessage = 'Email invalide.';
          break;
        case 'too-many-requests':
          errorMessage = 'Trop de tentatives. Réessayez plus tard.';
          break;
        case 'network-request-failed':
          errorMessage = 'Problème de connexion internet.';
          break;
      }
      setState(() {
        _message = errorMessage;
      });
    } catch (e) {
      print("⛔ Erreur inconnue : $e");
      setState(() {
        _message = 'Erreur inconnue lors de la connexion.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> resetPassword() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        _message = 'Veuillez entrer votre email pour réinitialiser.';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      setState(() {
        _message = 'Email de réinitialisation envoyé.';
      });
    } catch (e) {
      setState(() {
        _message = 'Erreur lors de l\'envoi du lien.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A92A5), Color(0xFF56C5D0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/logo.jpg'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 25),
                const Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: resetPassword,
                    child: const Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A92A5),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                if (_message.isNotEmpty)
                  Text(
                    _message,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}