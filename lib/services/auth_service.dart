import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {
        'user': result.user,
        'token': await result.user?.getIdToken(),
      };
    } on FirebaseAuthException catch (e) {
      return {
        'error': e.message,
        'code': e.code,
      };
    } catch (e) {
      return {
        'error': 'Erreur inconnue lors de la connexion.',
        'code': 'unknown',
      };
    }
  }

  static Future<Map<String, dynamic>> register({
    required String nom,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await result.user?.updateDisplayName(nom);

      return {
        'user': result.user,
        'message': 'Inscription réussie',
      };
    } on FirebaseAuthException catch (e) {
      return {
        'error': e.message,
        'code': e.code, // Ajouté pour cohérence
      };
    } catch (e) {
      return {
        'error': 'Erreur inconnue lors de l’inscription.',
        'code': 'unknown',
      };
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}