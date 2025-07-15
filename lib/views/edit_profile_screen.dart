import 'package:flutter/material.dart';
import 'package:unis_pour_aider/utils/session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? _user;

  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _message = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await SessionManager.getUser();
    setState(() {
      _user = user;
      _nomController.text = user?['nom'] ?? '';
      _emailController.text = user?['email'] ?? '';
    });
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final response = await http.put(
      Uri.parse('http://10.0.2.2:3000/users/${_user?['id']}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nom': _nomController.text,
        'email': _emailController.text,
        'motDePasse': _passwordController.text,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await SessionManager.saveUser({
        'id': _user!['id'],
        'nom': _nomController.text,
        'email': _emailController.text,
      }, _user!['token']);
      setState(() {
        _message = data['message'];
      });
      Navigator.pop(context); // Retour au profil
    } else {
      setState(() {
        _message = data['error'] ?? 'Erreur';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modifier le profil")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _user == null
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) =>
                value!.isEmpty ? 'Champ requis' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                value!.contains('@') ? null : 'Email invalide',
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Nouveau mot de passe'),
                obscureText: true,
                validator: (value) =>
                value!.length < 6 ? '6 caractères min.' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text("Enregistrer"),
              ),
              const SizedBox(height: 10),
              Text(_message, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
