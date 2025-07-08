class Campagne {
  final String id;
  final String titre;
  final String description;

  Campagne({
    required this.id,
    required this.titre,
    required this.description,
  });

  // Conversion depuis JSON
  factory Campagne.fromJson(Map<String, dynamic> json) {
    return Campagne(
      id: json['id'] as String,
      titre: json['titre'] as String,
      description: json['description'] as String,
    );
  }

  // Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
    };
  }
}
