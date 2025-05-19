import 'package:flutter/material.dart';

/// Utilidad para manejar la responsividad en la aplicación
///
/// Proporciona métodos y valores para adaptar la UI a diferentes
/// tamaños de pantalla y orientaciones.
class ResponsiveUtils {
  /// Indica si el dispositivo está en modo landscape
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Obtiene el ancho disponible para el contenido principal
  /// adaptándose a la orientación del dispositivo
  static double getContentWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscapeMode = isLandscape(context);
    
    // En landscape, limitar el ancho para evitar que el contenido se estire demasiado
    if (isLandscapeMode) {
      return screenWidth * 0.7;
    }
    
    // En portrait, usar ancho completo con padding estándar
    return screenWidth;
  }

  /// Obtiene el espaciado horizontal basado en el tamaño de pantalla
  static double getHorizontalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Espaciado proporcional al ancho de pantalla, con mínimos y máximos
    if (screenWidth > 600) {
      return 32.0; // Tablets y dispositivos más grandes
    } else if (screenWidth > 400) {
      return 24.0; // Teléfonos más grandes
    } else {
      return 16.0; // Teléfonos pequeños
    }
  }

  /// Ajusta un valor numérico según el tamaño de pantalla
  static double adaptValue(BuildContext context, double value, {double factor = 0.15}) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final baseSize = 375.0; // iPhone SE como referencia base
    
    // No permitir que el valor se reduzca demasiado en pantallas pequeñas
    final scaleFactor = (shortestSide / baseSize).clamp(0.85, 1.3);
    
    return value * scaleFactor;
  }

  /// Decide el número de columnas para grids según el ancho disponible
  static int getGridColumnCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth > 900) {
      return 4; // Pantallas muy grandes
    } else if (screenWidth > 600) {
      return 3; // Tablets
    } else if (screenWidth > 400) {
      return 2; // Teléfonos grandes
    } else {
      return 1; // Teléfonos pequeños
    }
  }
}
