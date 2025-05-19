import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';

/// Widget centralizado que proporciona un fondo con degradado para toda la aplicación.
///
/// Este componente implementa el fondo estándar de Agenda Glam, con un degradado
/// de azul oscuro que mantiene la estética masculina y elegante definida en el tema.
/// Se debe usar en todas las pantallas (excepto la de bienvenida que usa video).
class GlamGradientBackground extends StatelessWidget {
  /// Color primario para el degradado.
  /// Si no se especifica, usa kPrimaryColor del tema.
  final Color? primaryColor;
  
  /// Color secundario para el degradado.
  /// Si no se especifica, se calcula a partir del color primario.
  final Color? secondaryColor;
  
  /// Opacidad del degradado (0.0 - 1.0).
  /// Valores más altos producen un degradado más intenso.
  final double opacity;
  
  /// Dirección del degradado.
  /// Por defecto es de arriba hacia abajo.
  final Alignment beginAlignment;
  final Alignment endAlignment;
  
  /// Constructor del fondo estándar.
  const GlamGradientBackground({
    super.key,
    this.primaryColor,
    this.secondaryColor,
    this.opacity = 0.9,
    this.beginAlignment = Alignment.topCenter,
    this.endAlignment = Alignment.bottomCenter,
  });
  
  @override
  Widget build(BuildContext context) {
    // Determinar colores del degradado
    final Color effectivePrimaryColor = primaryColor ?? kPrimaryColor;
    final Color effectiveSecondaryColor = secondaryColor ?? 
        kBackgroundColor.withOpacity(opacity);
    
    return Container(
      decoration: BoxDecoration(
        // Degradado principal
        gradient: LinearGradient(
          begin: beginAlignment,
          end: endAlignment,
          colors: [
            effectivePrimaryColor,
            effectiveSecondaryColor,
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      // Cubrir toda la pantalla
      width: double.infinity,
      height: double.infinity,
    );
  }
}
