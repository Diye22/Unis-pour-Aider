import '../services/auth_service.dart';
import '../models/utilisateur_model.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<bool> login(String email, String motDePasse) {
    return _authService.login(email, motDePasse);
  }

  Future<bool> register(Utilisateur utilisateur) {
    return _authService.register(utilisateur);
  }
}
