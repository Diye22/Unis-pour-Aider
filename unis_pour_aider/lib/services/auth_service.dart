import '../models/utilisateur_model.dart';

class AuthService {
  // Simule une connexion
  Future<bool> login(String email, String motDePasse) async {
    // Logique fictive : accepte si email contient "@"
    await Future.delayed(const Duration(seconds: 1)); // Simulation délai réseau
    return email.contains('@') && motDePasse.length >= 6;
  }

  // Simule une inscription
  Future<bool> register(Utilisateur utilisateur) async {
    await Future.delayed(const Duration(seconds: 1));
    return utilisateur.email.contains('@') && utilisateur.motDePasse.length >= 6;
  }
}
