class Utilisateur {
  final String nom;
  final String email;
  final String motDePasse;

  Utilisateur({
    required this.nom,
    required this.email,
    required this.motDePasse,
  });

  // Factory pour créer un utilisateur à partir d’un JSON
  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      nom: json['nom'] as String,
      email: json['email'] as String,
      motDePasse: json['motDePasse'] as String,
    );
  }

  // Pour convertir en JSON (ex: avant envoi à l’API)
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'email': email,
      'motDePasse': motDePasse,
    };
  }
}
