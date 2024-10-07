import 'package:flutter/material.dart';

class AppColors {
  static const Color lightBackground = Colors.white;
  static const Color darkBackground = Color.fromRGBO(35, 34, 40, 1);
  
  static const Color lightPrimary = Color(0xFF2196F3); // Example light blue color
  static const Color darkPrimary = Color(0xFF263238); // Example dark grey color
  
  static const Color lightAccent = Colors.amber;
  static const Color darkAccent = Colors.deepOrange;
  
  static const Color textLight = Colors.black;
  static const Color textDark = Colors.white;

  // Define MaterialColor based on primary color
  static const MaterialColor lightPrimarySwatch = MaterialColor(
    0xFF2196F3, // Primary color
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  static const MaterialColor darkPrimarySwatch = MaterialColor(
    0xFF263238, // Primary color
    <int, Color>{
      50: Color(0xFFECEFF1),
      100: Color(0xFFCFD8DC),
      200: Color(0xFFB0BEC5),
      300: Color(0xFF90A4AE),
      400: Color(0xFF78909C),
      500: Color(0xFF607D8B),
      600: Color(0xFF546E7A),
      700: Color(0xFF455A64),
      800: Color(0xFF37474F),
      900: Color(0xFF263238),
    },
  );
}
