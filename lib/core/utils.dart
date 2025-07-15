import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class Utils {
  /// Format une date en `dd/MM/yyyy`
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format une date/heure en `dd/MM/yyyy HH:mm`
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  /// Tronque un texte à une certaine longueur
  static String truncate(String text, int maxLength) {
    return (text.length <= maxLength) ? text : '${text.substring(0, maxLength)}...';
  }

  /// Vérifie si un email est valide
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$");
    return emailRegex.hasMatch(email);
  }
}
