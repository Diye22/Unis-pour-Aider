import 'package:flutter/material.dart';

/// Couleurs principales utilisées dans toute l'application
class AppColors {
  static const Color primary = Color(0xFF3A92A5);      // Bleu principal
  static const Color secondary = Color(0xFF56C5D0);    // Bleu clair
  static const Color background = Color(0xFFF0F0F0);   // Gris très clair
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
  static const Color white = Colors.white;
}

/// Espacements constants (marges, paddings)
class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 32.0;
}

/// Rayon de bordure
class AppRadius {
  static const double normal = 10.0;
  static const double rounded = 20.0;
}

/// Police (si tu définis un thème avec une police spécifique)
class AppFonts {
  static const String primaryFont = 'Times New Roman';
}
