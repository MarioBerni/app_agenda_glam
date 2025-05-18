import 'dart:math' as math;
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Ícono de tijeras animado con rotación y efecto de zoom
///
/// Componente visual especializado para el ícono de tijeras en la página de bienvenida
/// que incluye una animación de rotación continua y efecto de zoom pulsante.
class GlamScissorsIcon extends StatelessWidget {
  /// Tamaño del contenedor (diámetro)
  final double size;

  /// Color de fondo del contenedor
  final Color? backgroundColor;

  /// Color del ícono
  final Color? iconColor;

  /// Si se deben aplicar animaciones
  final bool animate;

  /// Constructor
  const GlamScissorsIcon({
    super.key,
    this.size = 100.0,
    this.backgroundColor,
    this.iconColor,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    // Construir contenedor base con el mismo estilo que GlamIconContainer
    Widget container = Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? kSurfaceColor, // Usar el mismo color que en GlamIconContainer
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          // Solo el ícono tendrá animación, no todo el contenedor
          child: _buildScissorsIcon(),
        ),
      ),
    );

    // Aplicar animación de entrada para mantener coherencia con otros íconos
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

    // Mantener el efecto shimmer para coherencia con otros íconos
    container = container
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          delay: const Duration(milliseconds: 2000),
          duration: const Duration(milliseconds: 1800),
          color: kAccentColor.withValues(alpha: 0.3),
        );

    return container;
  }

  // Método que construye el ícono de tijera con animación de rotación y zoom
  Widget _buildScissorsIcon() {
    // Ícono base de tijera
    Widget scissorsIcon = Icon(
      Icons.content_cut,
      size: size * 0.5, // Mantener la misma proporción que otros íconos
      color: iconColor ?? kAccentColor, // Color dorado estándar
    );

    // Si la animación está desactivada, devolver ícono sin animar
    if (!animate) return scissorsIcon;

    // Aplicar animaciones de rotación y zoom usando controladores separados para mayor fluidez
    return scissorsIcon
        // Animación de rotación con su propio controlador para mayor suavidad
        .animate(onPlay: (controller) => controller.repeat())
        .rotate(
          duration: const Duration(seconds: 10), // Rotación lenta de 10 segundos
          begin: 0,
          end: 2.0, // Dos rotaciones completas
          curve: Curves.linear, // Movimiento uniforme
        )
        // Animación de pulso (zoom) con su propio controlador para evitar interferencias
        .animate(onPlay: (controller) => controller.repeat())
        // Usamos un solo efecto de escala con una curva sinusoidal para un movimiento fluido y continuo
        .custom(
          duration: const Duration(seconds: 4), // Un ciclo completo cada 4 segundos
          builder: (context, value, child) {
            // Usamos una función seno para crear un efecto de pulso suave
            // sin(...) oscila entre -1 y 1, lo transformamos para oscilar entre 0.9 y 1.3
            final pulse = 0.9 + (0.4 * ((math.sin(value * math.pi * 2) + 1) / 2));
            return Transform.scale(
              scale: pulse,
              child: child,
            );
          },
        );
  }
}
