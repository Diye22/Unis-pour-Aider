import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:unis_pour_aider/views/campagnes_list_screen.dart';
import 'package:unis_pour_aider/views/welcome_screen.dart';
import 'package:unis_pour_aider/views/map_screen.dart';
import 'package:unis_pour_aider/views/campagne_detail_screen.dart';
import 'package:unis_pour_aider/views/donation_screen.dart';
import 'package:unis_pour_aider/views/confirmation_screen.dart';
import 'package:unis_pour_aider/views/login_screen.dart';
import 'package:unis_pour_aider/views/signup_screen.dart';
import 'package:unis_pour_aider/views/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("✅ Firebase initialisé !");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unis pour Aider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/map': (context) => MapScreen(),
        '/list': (context) => CategoriesScreen(),
        '/detail': (context) => const CampagneDetailScreen(),
        '/donation': (context) => const DonationScreen(),
        '/confirmation': (context) => const ConfirmationScreen(),
        '/login': (context) =>  LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/pay': (context) => const ConfirmationScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3A92A5), Color(0xFF56C5D0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Text(
                  '🔍 La page "${settings.name}" est introuvable.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}