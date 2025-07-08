import 'package:flutter/material.dart';
import 'package:unis_pour_aider/views/campagnes_list_screen.dart';
import 'views/welcome_screen.dart';
import 'views/map_screen.dart';
import 'views/campagne_detail_screen.dart';
import 'views/donation_screen.dart';
import 'views/confirmation_screen.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';
import 'views/profile_screen.dart';
import 'views/confirmation_screen.dart';

void main() {
  runApp(UnisPourAiderApp());
}

class UnisPourAiderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unis pour Aider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3A92A5),
        scaffoldBackgroundColor: Color(0xFF3A92A5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
    );
  }
}