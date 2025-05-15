import 'package:flutter/material.dart';

// Paleta de colores para Agenda Glam (Azul y Dorado)
const Color kPrimaryColor = Color(
  0xFF00296B,
); // Royal Blue Traditional (AppBar)
const Color kPrimaryColorLight = Color(0xFF003F88); // Marian Blue
const Color kPrimaryColorDark = Color(0xFF00509D); // Polynesian Blue
const Color kAccentColor = Color(0xFFFDC500); // Mikado Yellow (Acento/Botones)
const Color kAccentColorAlt = Color(0xFFFFD500); // Gold (Acento alternativo)
const Color kBackgroundColor = Color(
  0xFF001B4D,
); // Versión más oscura de Royal Blue (Fondo)
const Color kSurfaceColor = Color(
  0xFF002C76,
); // Versión más oscura de Marian Blue (Superficies/Cards)
const Color kTextColor = Color(0xFFFFFFFF); // Blanco (Texto principal)
const Color kSecondaryTextColor = Color(
  0xFFB0BAC5,
); // Gris azulado (Texto secundario)
const Color kErrorColor = Color(0xFFCF6679); // Rojo error oscuro
const Color kOnPrimaryColor = kTextColor; // Texto sobre primario
const Color kOnAccentColor =
    Colors.black; // Texto sobre acento (negro sobre dorado)

// Color con opacidad para usar en varios lugares
// Usamos withAlpha en lugar de withOpacity para evitar el warning de deprecación
final Color kAccentColorWithOpacity = kAccentColor.withAlpha(
  102,
); // 0.4 * 255 = 102
final Color kSecondaryTextColorWithOpacity = kSecondaryTextColor.withAlpha(
  179,
); // 0.7 * 255 = 179
final Color kSurfaceColorWithOpacity = kSurfaceColor.withAlpha(
  179,
); // 0.7 * 255 = 179
final Color kAccentColorLightBg = kAccentColor.withAlpha(51); // 0.2 * 255 = 51
final Color kBlackWithOpacity = Colors.black.withAlpha(77); // 0.3 * 255 = 77

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
