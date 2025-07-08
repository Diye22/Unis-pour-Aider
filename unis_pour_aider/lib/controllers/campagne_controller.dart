import '../services/campagne_service.dart';
import '../models/campagne_model.dart';

class CampagneController {
  final CampagneService _campagneService = CampagneService();

  Future<List<Campagne>> getCampagnes() {
    return _campagneService.fetchCampagnes();
  }
}
