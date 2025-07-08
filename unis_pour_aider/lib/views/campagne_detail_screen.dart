import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CampagneDetailScreen extends StatelessWidget {
  const CampagneDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A92A5),
      appBar: const CustomAppBar(title: 'Détail Campagnes'),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: campagnes.length,
        itemBuilder: (context, index) {
          final item = campagnes[index];

          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 400 + index * 100),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 20),
                  child: campagneDetail(item['title']!, item['desc']!),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget campagneDetail(String title, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10),
            Text(
              description,
              style: GoogleFonts.raleway(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

// Liste des campagnes
final List<Map<String, String>> campagnes = [
  {
    'title': '1. Urgence Humanitaire',
    'desc': '• Humanité\n• Impartialité\n• Neutralité\n• Indépendance...'
  },
  {
    'title': '2. Pauvreté',
    'desc': 'Le revenu médiocre des ménages, le non accès à l’eau...'
  },
  {
    'title': '3. Don de sang',
    'desc': 'Le traitement des maladies, grands brûlés...'
  },
  {
    'title': '4. Éducation',
    'desc': 'Le manque de soin et de nourriture...'
  },
  {
    'title': '5. Inondation',
    'desc': 'Pluies abondantes, orages, fonte des neiges...'
  },
  {
    'title': '6. Environnement',
    'desc': 'Déforestation, pollution industrielle, etc...'
  },
];
