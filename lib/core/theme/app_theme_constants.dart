import 'package:flutter/material.dart';

// Paleta de colores para Agenda Glam (Elegante Oscura)
const Color kPrimaryColor = Color(0xFF0A1128);    // Azul marino profundo (AppBar)
const Color kAccentColor = Color(0xFFFFC107);     // Dorado/Ámbar (Acento/Botones)
const Color kBackgroundColor = Color(0xFF050A14);  // Negro azulado muy oscuro (Fondo)
const Color kSurfaceColor = Color(0xFF1E2A3B);     // Gris azulado oscuro (Superficies/Cards)
const Color kTextColor = Color(0xFFFFFFFF);        // Blanco (Texto principal)
const Color kSecondaryTextColor = Color(0xFFB0B8C1); // Gris plateado (Texto secundario)
const Color kErrorColor = Color(0xFFCF6679);       // Rojo error oscuro
const Color kOnPrimaryColor = kTextColor;          // Texto sobre primario
const Color kOnAccentColor = Colors.black;         // Texto sobre acento (negro sobre dorado)

// Color con opacidad para usar en varios lugares
// Usamos withAlpha en lugar de withOpacity para evitar el warning de deprecación
final Color kAccentColorWithOpacity = kAccentColor.withAlpha(102);      // 0.4 * 255 = 102
final Color kSecondaryTextColorWithOpacity = kSecondaryTextColor.withAlpha(179); // 0.7 * 255 = 179
final Color kSurfaceColorWithOpacity = kSurfaceColor.withAlpha(179);     // 0.7 * 255 = 179
final Color kAccentColorLightBg = kAccentColor.withAlpha(51);           // 0.2 * 255 = 51
final Color kBlackWithOpacity = Colors.black.withAlpha(77);             // 0.3 * 255 = 77

// Constantes de espaciado
const double kSpaceXXS = 2.0;
const double kSpaceXS = 4.0;
const double kSpaceS = 8.0;
const double kSpaceM = 16.0;
const double kSpaceL = 24.0;
const double kSpaceXL = 32.0;
const double kSpaceXXL = 48.0;

// Constantes de tamaños de fuente
const double kFontSizeXS = 12.0;
const double kFontSizeS = 14.0;
const double kFontSizeM = 16.0;
const double kFontSizeL = 18.0;
const double kFontSizeXL = 20.0;
const double kFontSizeXXL = 24.0;
const double kFontSizeHuge = 32.0;

// Constantes de radios de borde
const double kBorderRadiusS = 4.0;
const double kBorderRadiusM = 8.0;
const double kBorderRadiusL = 12.0;
const double kBorderRadiusXL = 16.0;
const double kBorderRadiusXXL = 24.0;
const double kBorderRadiusRound = 50.0;

// Constantes de elevaciones
const double kElevationNone = 0.0;
const double kElevationXS = 1.0;
const double kElevationS = 2.0;
const double kElevationM = 4.0;
const double kElevationL = 8.0;
const double kElevationXL = 16.0;

// Constantes de duración para animaciones
const Duration kDurationFast = Duration(milliseconds: 200);
const Duration kDurationMedium = Duration(milliseconds: 300);
const Duration kDurationSlow = Duration(milliseconds: 500);
