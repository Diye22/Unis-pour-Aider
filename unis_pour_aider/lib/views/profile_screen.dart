import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemples de données fictives (à remplacer par des vraies plus tard)
    final String nom = 'Fatou Ndiaye';
    final String email = 'fatou.ndiaye@example.com';
    final String phone = '+221 77 123 45 67';

    return Scaffold(
      backgroundColor: const Color(0xFF3A92A5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Mon Profil", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/logo.jpg'), // ou avatar de l'utilisateur
            ),
            const SizedBox(height: 16),

            Text(nom,
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(color: Colors.white70)),
            Text(phone, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                // Action : déconnexion, modifier profil, etc.
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF3A92A5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              icon: const Icon(Icons.logout),
              label: const Text("Se déconnecter"),
            ),
          ],
        ),
      ),
    );
  }
}
