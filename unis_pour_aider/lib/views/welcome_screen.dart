import 'package:flutter/material.dart';
import 'dart:ui';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient and image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3A92A5), Color(0xFF56C5D0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Glassmorphic overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Main content
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Glowing circular logo
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: ClipOval(
                      child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Stylized Title
                  Text(
                    'Unis pour Aider',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Button: Se connecter
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      foregroundColor: Color(0xFF3A92A5),
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      elevation: 8,
                      shadowColor: Colors.black26,
                    ),
                    child: Text('Se connecter'),
                  ),
                  const SizedBox(height: 20),

                  // Button: S'inscrire
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent.withOpacity(0.9),
                      foregroundColor: Colors.white,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      elevation: 8,
                      shadowColor: Colors.black26,
                    ),
                    child: Text("S'inscrire"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}