import '../models/campagne_model.dart';

class CampagneService {
  // Simule un appel API pour obtenir une liste de campagnes
  Future<List<Campagne>> fetchCampagnes() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulation d’un délai réseau

    return [
      Campagne(id: '1', titre: 'Urgence Humanitaire', description: 'Aide immédiate aux sinistrés.'),
      Campagne(id: '2', titre: 'Pauvreté', description: 'Aide alimentaire et soutien scolaire.'),
      Campagne(id: '3', titre: 'Don de sang', description: 'Campagne pour don de sang national.'),
    ];
  }
}
