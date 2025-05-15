import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';

/// Divisor elegante con gradiente dorado para separación visual
/// 
/// Proporciona un elemento visual consistente para separar secciones
/// en las diferentes pantallas de la aplicación.
class GlamDivider extends StatelessWidget {
  /// Altura del divisor
  final double height;
  
  /// Anchura del divisor (en relación a la pantalla)
  final double widthFactor;
  
  /// Color principal del gradiente
  final Color? primaryColor;
  
  /// Opacidad del color principal
  final double primaryOpacity;
  
  /// Si debe animarse al aparecer
  final bool animate;
  
  /// Constructor
  const GlamDivider({
    super.key,
    this.height = 1.0,
    this.widthFactor = 1.0,
    this.primaryColor,
    this.primaryOpacity = 0.6,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    // Construir el divisor con gradiente
    Widget divider = FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              (primaryColor ?? kAccentColor).withOpacity(primaryOpacity),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
    
    // Aplicar animación si está habilitada
    if (animate) {
      return divider.glamEntry(
        duration: const Duration(milliseconds: 900),
      );
    }
    
    return divider;
  }
}

/// Versión del divisor con texto centrado
class GlamTextDivider extends StatelessWidget {
  /// Texto a mostrar en el centro del divisor
  final String text;
  
  /// Estilo del texto
  final TextStyle? textStyle;
  
  /// Altura del divisor
  final double dividerHeight;
  
  /// Color principal del gradiente
  final Color? primaryColor;
  
  /// Opacidad del color principal
  final double primaryOpacity;
  
  /// Espaciado horizontal
  final double horizontalPadding;
  
  /// Constructor
  const GlamTextDivider({
    super.key,
    required this.text,
    this.textStyle,
    this.dividerHeight = 1.0,
    this.primaryColor,
    this.primaryOpacity = 0.6,
    this.horizontalPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: horizontalPadding),
      child: Row(
        children: [
          // Divisor izquierdo
          Expanded(
            child: GlamDivider(
              height: dividerHeight,
              primaryColor: primaryColor,
              primaryOpacity: primaryOpacity,
            ),
          ),
          
          // Texto central
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              text,
              style: textStyle ?? TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // Divisor derecho
          Expanded(
            child: GlamDivider(
              height: dividerHeight,
              primaryColor: primaryColor,
              primaryOpacity: primaryOpacity,
            ),
          ),
        ],
      ),
    ).glamEntry(
      duration: const Duration(milliseconds: 1000),
    );
  }
}
