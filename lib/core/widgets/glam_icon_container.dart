// No necesitamos importar animation_presets directamente ya que usamos Flutter Animate
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Contenedor circular para iconos con estilo visual unificado
/// 
/// Proporciona un contenedor circular con colores y efectos visuales consistentes
/// para los iconos en las diferentes pantallas de la aplicación.
class GlamIconContainer extends StatelessWidget {
  /// Icono a mostrar en el contenedor
  final IconData icon;
  
  /// Tamaño del contenedor (diámetro)
  final double size;
  
  /// Color de fondo del contenedor
  final Color? backgroundColor;
  
  /// Color del icono
  final Color? iconColor;
  
  /// Efecto de brillo (shimmer) periódico
  final bool enableShimmer;
  
  /// Animación de entrada
  final bool animateEntry;
  
  /// Constructor
  const GlamIconContainer({
    super.key,
    required this.icon,
    this.size = 100.0,
    this.backgroundColor,
    this.iconColor,
    this.enableShimmer = true,
    this.animateEntry = true,
  });

  @override
  Widget build(BuildContext context) {
    // Construir contenedor base
    Widget container = Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? kSurfaceColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            size: size * 0.5,
            color: iconColor ?? kAccentColor,
          ),
        ),
      ),
    );
    
    // Aplicar animaciones según configuración
    if (animateEntry) {
      container = container
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.7, 0.7),
          end: const Offset(1.0, 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
        );
    }
    
    // Añadir efecto shimmer si está habilitado
    if (enableShimmer) {
      container = container
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          delay: const Duration(milliseconds: 2000),
          duration: const Duration(milliseconds: 1800),
          color: kAccentColor.withOpacity(0.3),
        );
    }
    
    return container;
  }
}
