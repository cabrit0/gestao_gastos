import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.indigo, // Cor primária exemplo
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // Outras personalizações: appBarTheme, textTheme, colorScheme, inputDecorationTheme etc.
      appBarTheme: const AppBarTheme(
        elevation: 1, // Exemplo
        centerTitle: true,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ).copyWith(secondary: Colors.amber), // Accent color
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(elevation: 1, centerTitle: true),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ).copyWith(secondary: Colors.amber),
    );
  }
}
