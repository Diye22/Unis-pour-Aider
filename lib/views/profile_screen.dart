import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unis_pour_aider/utils/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final user = await SessionManager.getUser();
    final id = user?['id'];

    final response = await http.get(Uri.parse('http://10.0.2.2:3000/users/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        userData = data;
      });
    } else {
      setState(() {
        userData = {'nom': 'Inconnu', 'email': 'Erreur'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nom = userData?['nom'] ?? 'Chargement...';
    final email = userData?['email'] ?? '';
    final phone = '+221 77 123 45 67';

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
              backgroundImage: AssetImage('assets/images/logo.jpg'), // ← juste le logo
            ),
            const SizedBox(height: 16),
            Text(
              nom,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(color: Colors.white70)),
            Text(phone, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/edit-profile');
              },
              icon: const Icon(Icons.edit),
              label: const Text("Modifier le profil"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF3A92A5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
