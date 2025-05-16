import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';

/// Widget que proporciona un fondo elegante y dinámico con
/// degradados, formas geométricas y efectos de parallax sutiles.
class GlamBackground extends StatefulWidget {
  /// El color primario del gradiente
  final Color? primaryColor;

  /// El color secundario del gradiente
  final Color? secondaryColor;

  /// Determina si el fondo tendrá un efecto de movimiento
  final bool animate;

  /// La opacidad de los elementos decorativos
  final double decorationOpacity;

  /// La densidad de elementos decorativos (formas geométricas)
  final double decorationDensity;

  /// La intensidad general de los efectos visuales
  final double intensity;

  const GlamBackground({
    super.key,
    this.primaryColor,
    this.secondaryColor,
    this.animate = true,
    this.decorationOpacity = 0.15,
    this.decorationDensity = 0.8,
    this.intensity = 1.0,
  });

  @override
  State<GlamBackground> createState() => _GlamBackgroundState();
}

class _GlamBackgroundState extends State<GlamBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Configurar controlador de animación
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    _animation = Tween<double>(begin: 0, end: math.pi * 2).animate(_controller);

    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = widget.primaryColor ?? kPrimaryColorDark;
    final secondaryColor = widget.secondaryColor ?? kBackgroundColor;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            // Gradiente de fondo
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, secondaryColor],
                  stops: const [0.3, 0.9],
                ),
              ),
            ),

            // Overlay con patrón geométrico
            CustomPaint(
              painter: GeometricPatternPainter(
                phase: _animation.value,
                patternColor: theme.colorScheme.primary,
                opacity: widget.decorationOpacity * widget.intensity,
                density: widget.decorationDensity * widget.intensity,
                intensity: widget.intensity,
              ),
              size: Size.infinite,
            ),

            // Resplandor superior
            Positioned(
              top: -100,
              right: -50,
              child: Container(
                width: 300 * widget.intensity,
                height: 300 * widget.intensity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      theme.colorScheme.secondary.withValues(
                        alpha: 0.2 * widget.intensity,
                      ),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Resplandor inferior
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 350 * widget.intensity,
                height: 350 * widget.intensity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      kPrimaryColorLight.withValues(
                        alpha: 0.12 * widget.intensity,
                      ),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Capa de overlay para oscurecer ligeramente y añadir textura
            Container(
              color: Colors.black.withValues(alpha: 0.05 * widget.intensity),
            ),
          ],
        );
      },
    );
  }
}

/// Pintor personalizado que dibuja formas geométricas distribuidas
/// en el lienzo para crear un efecto de profundidad y elegancia.
class GeometricPatternPainter extends CustomPainter {
  final double phase;
  final Color patternColor;
  final double opacity;
  final double density;
  final double intensity;

  const GeometricPatternPainter({
    required this.phase,
    required this.patternColor,
    this.opacity = 0.1,
    this.density = 1.0,
    this.intensity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = patternColor.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    final int elementsCount = (20 * density).round();
    final random = math.Random(42); // Semilla fija para consistencia

    // Dibujar líneas geométricas
    for (int i = 0; i < elementsCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final elementSize = (random.nextDouble() * 30 + 10) * density;
      final moveOffset = math.sin(phase + i * 0.1) * 5 * density * intensity;

      // Decidir qué tipo de forma dibujar
      final shapeType = random.nextInt(3);

      switch (shapeType) {
        case 0: // Rombo
          _drawDiamond(canvas, paint, Offset(x + moveOffset, y), elementSize);
          break;
        case 1: // Línea de puntos
          _drawDottedLine(
            canvas,
            paint,
            Offset(x, y + moveOffset),
            elementSize,
            phase,
          );
          break;
        case 2: // Triángulo
          _drawTriangle(canvas, paint, Offset(x - moveOffset, y), elementSize);
          break;
      }
    }
  }

  void _drawDiamond(Canvas canvas, Paint paint, Offset center, double size) {
    final path =
        Path()
          ..moveTo(center.dx, center.dy - size / 2)
          ..lineTo(center.dx + size / 2, center.dy)
          ..lineTo(center.dx, center.dy + size / 2)
          ..lineTo(center.dx - size / 2, center.dy)
          ..close();

    canvas.drawPath(path, paint);
  }

  void _drawDottedLine(
    Canvas canvas,
    Paint paint,
    Offset start,
    double length,
    double phase,
  ) {
    final endX = start.dx + length;
    final dotInterval = 4.0;
    final animationOffset = (phase * 2) % dotInterval;

    for (double x = start.dx - animationOffset; x < endX; x += dotInterval) {
      canvas.drawCircle(Offset(x, start.dy), 1.0, paint);
    }
  }

  void _drawTriangle(Canvas canvas, Paint paint, Offset center, double size) {
    final path =
        Path()
          ..moveTo(center.dx, center.dy - size / 2)
          ..lineTo(center.dx + size / 2, center.dy + size / 2)
          ..lineTo(center.dx - size / 2, center.dy + size / 2)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(GeometricPatternPainter oldDelegate) {
    return oldDelegate.phase != phase;
  }
}
