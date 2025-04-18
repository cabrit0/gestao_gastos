import 'package:flutter/material.dart';

class AppTheme {
  // Cores personalizadas para o tema - Paleta financeira moderna
  static const Color _primaryColor = Color(0xFF0A6EBD); // Azul profissional
  static const Color _secondaryColor = Color(0xFF5FBDFF); // Azul claro
  static const Color _tertiaryColor = Color(0xFF16FF00); // Verde vibrante
  static const Color _errorColor = Color(0xFFE74646); // Vermelho suave

  // Cores para categorias de transações
  static const Color expenseColor = Color(0xFFE74646); // Vermelho para despesas
  static const Color incomeColor = Color(0xFF16FF00); // Verde para receitas
  static const Color transferColor = Color(
    0xFFFFB100,
  ); // Laranja para transferências

  // Tema claro
  static ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.light(
      // Cores primárias - Azul profissional
      primary: _primaryColor, // Azul profissional
      onPrimary: Colors.white, // Branco para texto sobre primário
      primaryContainer: Color(0xFFB9E0FF), // Azul claro para containers
      onPrimaryContainer: Color(
        0xFF0A2647,
      ), // Azul escuro para texto sobre containers
      // Cores secundárias - Tons complementares
      secondary: _secondaryColor, // Azul claro
      onSecondary: Color(0xFF0A2647), // Azul escuro para texto sobre secundário
      secondaryContainer: Color(
        0xFFDFF6FF,
      ), // Azul muito claro para containers secundários
      onSecondaryContainer: Color(
        0xFF0A2647,
      ), // Azul escuro para texto sobre containers secundários
      // Cores terciárias - Verde para elementos positivos (receitas)
      tertiary: _tertiaryColor, // Verde vibrante
      onTertiary: Colors.white, // Branco para texto sobre terciário
      tertiaryContainer: Color(0xFFB6FFAA), // Verde claro para containers
      onTertiaryContainer: Color(
        0xFF146B3A,
      ), // Verde escuro para texto sobre containers
      // Cores de erro - Vermelho suave
      error: _errorColor, // Vermelho suave para erros e despesas
      onError: Colors.white, // Branco para texto sobre erro
      errorContainer: Color(
        0xFFFFDAD6,
      ), // Vermelho claro para containers de erro
      onErrorContainer: Color(
        0xFF8B2635,
      ), // Vermelho escuro para texto sobre containers de erro
      // Cores de superfície - Tons claros sofisticados
      surface: Colors.white, // Branco para superfícies
      onSurface: Color(0xFF0A2647), // Azul escuro para texto sobre superfícies
      surfaceContainerHighest: Color(
        0xFFEEF5FF,
      ), // Azul muito claro para containers de superfície
      surfaceContainerHigh: Color(
        0xFFE3F4FF,
      ), // Azul claro para containers de superfície
      surfaceContainer: Color(
        0xFFD9F1FF,
      ), // Azul claro para containers de superfície
      surfaceContainerLow: Color(
        0xFFCEEDFF,
      ), // Azul claro para containers de superfície
      surfaceContainerLowest: Color(
        0xFFC4E7FF,
      ), // Azul claro para containers de superfície
      surfaceBright: Colors.white, // Branco para superfícies brilhantes
      surfaceDim: Color(
        0xFFEEF5FF,
      ), // Azul muito claro para superfícies escuras
      outline: Color(0xFF5FBDFF), // Azul claro para bordas e divisões
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withAlpha(77),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  // Tema escuro
  static ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.dark(
      // Cores primárias - Azul profissional
      primary: Color(0xFF5FBDFF), // Azul claro para destaque
      onPrimary: Color(0xFF0A2647), // Azul escuro para texto sobre primário
      primaryContainer: Color(0xFF144272), // Azul médio para containers
      onPrimaryContainer: Color(
        0xFFB9E0FF,
      ), // Azul muito claro para texto sobre containers
      // Cores secundárias - Tons complementares
      secondary: Color(0xFF86E5FF), // Azul ciano para elementos secundários
      onSecondary: Color(0xFF0A2647), // Azul escuro para texto sobre secundário
      secondaryContainer: Color(
        0xFF205295,
      ), // Azul médio-escuro para containers secundários
      onSecondaryContainer: Color(
        0xFFB9E0FF,
      ), // Azul claro para texto sobre containers secundários
      // Cores terciárias - Verde para elementos positivos (receitas)
      tertiary: Color(0xFF16FF00), // Verde vibrante
      onTertiary: Color(0xFF0A2647), // Azul escuro para texto sobre terciário
      tertiaryContainer: Color(0xFF146B3A), // Verde escuro para containers
      onTertiaryContainer: Color(
        0xFFB6FFAA,
      ), // Verde claro para texto sobre containers
      // Cores de erro - Vermelho suave
      error: Color(0xFFE74646), // Vermelho suave para erros e despesas
      onError: Color(0xFFFFFFFF), // Branco para texto sobre erro
      errorContainer: Color(
        0xFF8B2635,
      ), // Vermelho escuro para containers de erro
      onErrorContainer: Color(
        0xFFFFDAD6,
      ), // Vermelho muito claro para texto sobre containers de erro
      // Cores de superfície - Tons escuros sofisticados
      surface: Color(0xFF0A2647), // Azul muito escuro para superfícies
      onSurface: Color(0xFFE6E1E5), // Cinza claro para texto sobre superfícies
      surfaceContainerHighest: Color(
        0xFF144272,
      ), // Azul escuro para containers de superfície
      surfaceContainerHigh: Color(
        0xFF0F3460,
      ), // Azul escuro médio para containers de superfície
      surfaceContainer: Color(
        0xFF0A2647,
      ), // Azul escuro para containers de superfície
      surfaceContainerLow: Color(
        0xFF071330,
      ), // Azul muito escuro para containers de superfície
      surfaceContainerLowest: Color(
        0xFF050A30,
      ), // Azul muito escuro para containers de superfície
      surfaceBright: Color(
        0xFF205295,
      ), // Azul médio para superfícies brilhantes
      surfaceDim: Color(
        0xFF071330,
      ), // Azul muito escuro para superfícies escuras
      outline: Color(0xFF2C74B3), // Azul médio para bordas e divisões
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withAlpha(77),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}
