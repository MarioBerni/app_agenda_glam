import 'package:flutter/material.dart';
import 'app_theme_constants.dart';

class AppTheme {
  /// El tema principal de la aplicación (tema oscuro elegante y masculino)
  static final ThemeData appTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: kPrimaryColor,
      secondary: kAccentColor,
      surface: kSurfaceColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kPrimaryColor,
      elevation: 2, // Ligera elevación para dar profundidad
      shadowColor: Colors.black45, // Sombra sutil
      iconTheme: IconThemeData(color: kOnPrimaryColor),
      titleTextStyle: TextStyle(
        color: kOnPrimaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5, // Espaciado de letras para elegancia
      ),
      centerTitle: true, // Centrar título por defecto
    ),
    textTheme: const TextTheme(
      // Títulos
      displayLarge: TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
      ),
      displayMedium: TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
      ),
      displaySmall: TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),

      // Encabezados
      headlineLarge: TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      headlineMedium: TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.25,
      ),
      headlineSmall: TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.25,
      ),

      // Cuerpo de texto
      bodyLarge: TextStyle(color: kTextColor, letterSpacing: 0.15),
      bodyMedium: TextStyle(color: kSecondaryTextColor, letterSpacing: 0.15),
      bodySmall: TextStyle(color: kSecondaryTextColor, letterSpacing: 0.1),

      // Etiquetas y botones
      labelLarge: TextStyle(
        color: kAccentColor,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        color: kAccentColor,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        color: kSecondaryTextColor,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    ),

    // Botones elevados (principales)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kAccentColor,
        foregroundColor: kOnAccentColor,
        elevation: 3, // Mayor elevación para destacar
        shadowColor: kAccentColorWithOpacity, // Sombra del color de acento
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Botones de texto (secundarios)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kAccentColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Botones con contorno
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kAccentColor,
        side: const BorderSide(color: kAccentColor, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),

    // Campos de texto
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kSurfaceColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: kAccentColor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: kErrorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: kErrorColor, width: 2.0),
      ),
      labelStyle: const TextStyle(color: kSecondaryTextColor),
      hintStyle: TextStyle(color: kSecondaryTextColorWithOpacity),
      prefixIconColor: kSecondaryTextColor,
      suffixIconColor: kSecondaryTextColor,
    ),

    // Tarjetas
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: kBlackWithOpacity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: kSurfaceColor,
      clipBehavior:
          Clip.antiAlias, // Para imágenes y contenido que podría desbordar
    ),

    // Diálogos
    dialogTheme: DialogTheme(
      backgroundColor: kSurfaceColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),

    // Chips
    chipTheme: ChipThemeData(
      backgroundColor: kSurfaceColor,
      disabledColor: kSurfaceColorWithOpacity,
      selectedColor: kAccentColorLightBg,
      secondarySelectedColor: kAccentColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: const TextStyle(color: kTextColor),
      secondaryLabelStyle: const TextStyle(color: kOnAccentColor),
      brightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: kAccentColor),
      ),
    ),

    // Iconos
    iconTheme: const IconThemeData(color: kSecondaryTextColor, size: 24),

    // Divisores
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2D3A4A), // Un poco más claro que el color de superficie
      thickness: 1,
      space: 24,
    ),

    // SnackBar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: kSurfaceColor,
      contentTextStyle: const TextStyle(color: kTextColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      behavior: SnackBarBehavior.floating,
      actionTextColor: kAccentColor,
    ),

    useMaterial3: true,
  );
}
