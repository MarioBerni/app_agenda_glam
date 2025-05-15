import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Widget que muestra el logo de Agenda Glam con animaciones elegantes
/// Se puede configurar el tamaÃ±o, colores y tipo de animaciÃ³n
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.secondary;

    final logo = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo con cÃ­rculo y glow
        Stack(
          alignment: Alignment.center,
          children: [
            // CÃ­rculo de fondo con degradado
            Container(
              width: size * 1.2,
              height: size * 1.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [accentColor, accentColor.withValues(alpha: 0.1)],
                  stops: const [0.5, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            // Ãcono central
            Icon(Icons.schedule, size: size, color: Colors.white),
          ],
        ),

        const SizedBox(height: 16),

        // TÃ­tulo
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

    // Si no hay animaciÃ³n, devolver el widget sin animar
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

    // AÃ±adir efecto de shimmer si estÃ¡ activado
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
