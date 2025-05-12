import 'package:flutter/material.dart';

class AppTheme {
  // Define colores base para el tema oscuro
  static const Color _primaryColorDark = Color(0xFFBB86FC); // Un púrpura suave como acento
  static const Color _secondaryColorDark = Color(0xFF03DAC6); // Un teal como secundario
  static const Color _backgroundColorDark = Color(0xFF121212); // Negro casi puro para fondo
  static const Color _surfaceColorDark = Color(0xFF1E1E1E); // Un gris oscuro para superficies
  static const Color _errorColorDark = Color(0xFFCF6679);
  static const Color _onPrimaryColorDark = Colors.black;
  static const Color _onSecondaryColorDark = Colors.black;
  static const Color _onBackgroundColorDark = Colors.white;
  static const Color _onSurfaceColorDark = Colors.white;
  static const Color _onErrorColorDark = Colors.black;

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryColorDark,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColorDark,
      secondary: _secondaryColorDark,
      background: _backgroundColorDark,
      surface: _surfaceColorDark,
      error: _errorColorDark,
      onPrimary: _onPrimaryColorDark,
      onSecondary: _onSecondaryColorDark,
      onBackground: _onBackgroundColorDark,
      onSurface: _onSurfaceColorDark,
      onError: _onErrorColorDark,
      // primaryVariant y secondaryVariant no están directamente en ColorScheme,
      // se usan implícitamente o se definen en otros lugares si es necesario.
    ),
    scaffoldBackgroundColor: _backgroundColorDark,
    appBarTheme: const AppBarTheme(
      color: _surfaceColorDark, // Fondo de AppBar
      elevation: 0,
      iconTheme: IconThemeData(color: _onSurfaceColorDark),
      titleTextStyle: TextStyle(
        color: _onSurfaceColorDark,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      // Define estilos de texto si es necesario
      // Por ejemplo, para asegurar buena legibilidad
      bodyLarge: TextStyle(color: _onBackgroundColorDark),
      bodyMedium: TextStyle(color: _onSurfaceColorDark),
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColorDark,
        foregroundColor: _onPrimaryColorDark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceColorDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: _primaryColorDark),
      ),
      labelStyle: TextStyle(color: _onSurfaceColorDark.withOpacity(0.7)),
    ),
    useMaterial3: true,
    // Puedes añadir más personalizaciones aquí (CardTheme, BottomNavigationBarTheme, etc.)
  );

  // Podrías definir un lightTheme aquí también si fuera necesario
  // static final ThemeData lightTheme = ThemeData(...);
}
