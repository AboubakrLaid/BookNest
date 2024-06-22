import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}

ThemeData kLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.inter().fontFamily,
  scaffoldBackgroundColor: const Color(0xFFF0F0F0),
  primaryColor: const Color(0xFF20C57A),
  secondaryHeaderColor: const Color(0xFFD9D9D9),

 

);

ThemeData kDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.inter().fontFamily,
  scaffoldBackgroundColor: const Color(0xFF232F38),
  primaryColor: const Color(0xFF20C57A),
  secondaryHeaderColor: const Color(0xFF343e46),
);