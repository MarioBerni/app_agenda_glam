import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Widget que muestra el logo de Agenda Glam con animaciones elegantes
/// Se puede configurar el tamaño, colores y tipo de animación
class GlamLogo extends StatelessWidget {
  final double size;
  final bool showTagline;
  final bool animate;
  final Duration animationDuration;
  final bool showShimmer;

  const GlamLogo({
    super.key,
    this.size = 80,
    this.showTagline = true,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.showShimmer = true,
  });

  // Construye el ícono de tijera estático (sin animación)
  Widget _buildStaticScissors(double size) {
    return Icon(
      Icons.content_cut,  // Ícono de tijera
      size: size * 0.6,    // Ajustamos el tamaño para que quede proporcional
      color: const Color(0xFFFFD700), // Color dorado/amarillo para mantener coherencia
    );
  }

  // Construye el ícono de tijera con animaciones
  Widget _buildAnimatedScissors(double size) {
    // Color dorado para el ícono (igual que los demás íconos de la app)
    const Color goldColor = Color(0xFFFFD700);
    
    return Icon(
      Icons.content_cut, // Ícono de tijera
      size: size * 0.6,   // Proporcional al tamaño del logo (ajustado para mantener coherencia)
      color: goldColor,   // Color dorado para mantener coherencia visual
    )
    .animate(onPlay: (controller) => controller.repeat()) // Repetir la animación indefinidamente
    // Efecto principal: rotación sutil de tijeras que simula el corte
    .rotate(
      duration: const Duration(seconds: 5),
      begin: -0.05,
      end: 0.05,
      curve: Curves.easeInOutSine,
      alignment: Alignment.center,
    )
    // Efecto de apertura y cierre de tijeras (más sutil)
    .scale(
      delay: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.1, 1.1), // Escalado más sutil
      curve: Curves.easeInOutSine,
    )
    .then() // Encadenar con el cierre de tijeras
    .scale(
      duration: const Duration(seconds: 2),
      begin: const Offset(1.1, 1.1),
      end: const Offset(1.0, 1.0),
      curve: Curves.easeInOutSine,
    )
    // Efecto de brillo ocasional con color dorado
    .shimmer(
      delay: const Duration(seconds: 4),
      duration: const Duration(milliseconds: 1800),
      color: goldColor.withValues(alpha: 153), // 0.6 * 255 = 153 (Brillo con el mismo color dorado)
      size: 0.8,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.secondary;

    final logo = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo con ícono de tijera y glow
        Stack(
          alignment: Alignment.center,
          children: [
            // Círculo de fondo azul oscuro (como los otros íconos)
            Container(
              width: size * 1.2,
              height: size * 1.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0A1835), // Color azul oscuro para el fondo
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 51), // 0.2 * 255 = 51
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            // Ícono de tijera con animación
            animate ? _buildAnimatedScissors(size) : _buildStaticScissors(size),
          ],
        ),

        const SizedBox(height: 16),

        // Título
        Text(
          'Agenda Glam',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: accentColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),

        if (showTagline) ...[
          const SizedBox(height: 8),
          // Tagline
          Text(
            'Tu agenda de belleza masculina',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    // Si no hay animación, devolver el widget sin animar
    if (!animate) return logo;

    // Aplicar animaciones usando flutter_animate
    var animatedLogo = logo
        .animate()
        // Efecto de entrada con escala y desvanecimiento
        .fadeIn(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuad,
        )
        .scale(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 800),
          begin: const Offset(0.0, 0.0),
          end: const Offset(1.0, 1.0),
          curve: Curves.elasticOut,
        );

    // Añadir efecto de shimmer si está activado
    if (showShimmer) {
      animatedLogo = animatedLogo.shimmer(
        delay: const Duration(milliseconds: 1200),
        duration: const Duration(milliseconds: 1800),
        color: accentColor.withValues(alpha: 0.7),
      );
    }

    return animatedLogo;
  }
}
