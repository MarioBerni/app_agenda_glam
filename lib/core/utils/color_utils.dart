import 'package:flutter/material.dart';

/// Utilidades para trabajar con colores
class ColorUtils {
  /// Aplica un valor de opacidad usando [Color.withAlpha] para evitar problemas de precisión
  /// 
  /// [color] El color base
  /// [opacity] Valor de opacidad entre 0.0 y 1.0
  /// 
  /// Retorna un nuevo color con la opacidad especificada
  static Color withOpacityValue(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }
  
  /// Aplica transparencia a un color manteniendo sus componentes RGB
  /// 
  /// Método semántico que utiliza withAlpha() internamente
  static Color transparent(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }
  
  // Evita instanciación
  ColorUtils._();
}
