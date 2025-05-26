import 'dart:math' show Random;
import 'package:flutter/material.dart';

/// Clase para almacenar datos de círculos animados
class AnimatedCircle {
  double posX;
  double posY;
  double velocityX;
  double velocityY;
  double radius;
  double opacity;
  double strokeWidth;
  
  AnimatedCircle({
    required this.posX,
    required this.posY,
    required this.velocityX,
    required this.velocityY,
    required this.radius,
    required this.opacity,
    required this.strokeWidth,
  });
}

/// Widget centralizado mejorado que proporciona un fondo con degradado
/// para toda la aplicación.
///
/// Este componente implementa el fondo estándar mejorado de Agenda Glam,
/// con degradados sofisticados que mantienen la estética masculina y elegante
/// definida en el tema.
class GlamGradientBackground extends StatefulWidget {
  /// Color primario para el degradado.
  /// Si no se especifica, usa kPrimaryColor del tema.
  final Color? primaryColor;
  
  /// Color secundario para el degradado.
  /// Si no se especifica, se calcula a partir del color primario.
  final Color? secondaryColor;
  
  /// Opacidad del degradado (0.0 - 1.0).
  final double opacity;
  
  /// Color adicional para el degradado.
  /// Si no se especifica, se calcula a partir del color primario.
  final Color? accentColor;
  
  /// Determina si se muestran elementos decorativos adicionales.
  final bool showDecorationElements;
  
  /// Determina si se muestra el círculo animado que rebota.
  final bool showBouncingCircle;
  
  /// Constructor del fondo estándar mejorado.
  const GlamGradientBackground({
    super.key,
    this.primaryColor,
    this.secondaryColor,
    this.accentColor,
    this.opacity = 0.9,
    this.showDecorationElements = true,
    this.showBouncingCircle = true,
  });
  
  @override
  State<GlamGradientBackground> createState() => _GlamGradientBackgroundState();
}

class _GlamGradientBackgroundState extends State<GlamGradientBackground>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  
  // Lista de círculos animados
  late List<AnimatedCircle> _circles;
  
  @override
  void initState() {
    super.initState();
    
    // Inicializar círculos animados
    _initCircles();
    
    // Configurar controlador de animación
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    
    // Escuchar cada frame para actualizar posición
    _animationController.addListener(_updatePosition);
  }
  
  /// Inicializa múltiples círculos animados con diferentes tamaños
  void _initCircles() {
    final random = Random();
    _circles = [];
    
    // Definir una variedad de tamaños de círculos
    final circleSizes = [
      // radio, opacidad, grosor de borde
      [6.0, 0.09, 0.8],   // Muy pequeño
      [8.0, 0.08, 1.0],   // Pequeño
      [12.0, 0.07, 1.2],  // Mediano
      [16.0, 0.06, 1.5],  // Grande
      [24.0, 0.05, 1.8],  // Muy grande
    ];
    
    // Crear 13 círculos con tamaños aleatorios (2 más que antes)
    for (int i = 0; i < 13; i++) {
      // Seleccionar un tamaño aleatorio del array de tamaños
      final sizeData = circleSizes[random.nextInt(circleSizes.length)];
      final radius = sizeData[0];
      final opacity = sizeData[1];
      final strokeWidth = sizeData[2];
      
      // Posición inicial aleatoria
      final posX = random.nextDouble() * 0.8 + 0.1; // Entre 10% y 90% del ancho
      final posY = random.nextDouble() * 0.8 + 0.1; // Entre 10% y 90% del alto
      
      // La velocidad es inversamente proporcional al tamaño (círculos más grandes se mueven más lento)
      final baseSpeed = 0.001 + (random.nextDouble() * 0.001);
      final speedFactor = 1.0 - (radius / 30.0); // Más grande = más lento
      final velocityX = baseSpeed * speedFactor;
      final velocityY = baseSpeed * speedFactor;
      
      // Añadir a la lista de círculos
      _circles.add(AnimatedCircle(
        posX: posX,
        posY: posY,
        velocityX: random.nextBool() ? velocityX : -velocityX,
        velocityY: random.nextBool() ? velocityY : -velocityY,
        radius: radius,
        opacity: opacity,
        strokeWidth: strokeWidth,
      ));
    }
  }
  
  void _updatePosition() {
    if (!widget.showBouncingCircle) return;
    
    setState(() {
      // Actualizar todos los círculos
      for (var circle in _circles) {
        // Actualizar posición basada en velocidad
        circle.posX += circle.velocityX;
        circle.posY += circle.velocityY;
        
        // Verificar rebotes en bordes horizontales
        if (circle.posX <= 0 || circle.posX >= 1.0) {
          circle.velocityX *= -1; // Invertir dirección horizontal
          // Asegurar que se mueva al menos un poco lejos del borde
          circle.posX = circle.posX <= 0 ? 0.01 : 0.99;
        }
        
        // Verificar rebotes en bordes verticales
        if (circle.posY <= 0 || circle.posY >= 1.0) {
          circle.velocityY *= -1; // Invertir dirección vertical
          // Asegurar que se mueva al menos un poco lejos del borde
          circle.posY = circle.posY <= 0 ? 0.01 : 0.99;
        }
      }
    });
  }
  
  @override
  void dispose() {
    _animationController.removeListener(_updatePosition);
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Determinar colores principales para el degradado más intenso
    // Usando colores más fuertes y saturados para un impacto visual mayor
    final Color effectivePrimaryColor = widget.primaryColor ?? 
        const Color(0xFF001F63); // Azul más intenso para la parte superior
    final Color effectiveSecondaryColor = widget.secondaryColor ?? 
        const Color(0xFF000C33).withValues(alpha: widget.opacity); // Azul muy oscuro casi negro para la base
    final Color effectiveAccentColor = widget.accentColor ?? 
        const Color(0xFF0031A6).withValues(alpha: 0.95); // Azul medio intenso para contraste
    
    return Stack(
      children: [
        // Degradado de fondo con azul intenso y transiciones más marcadas
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                effectivePrimaryColor,
                effectiveAccentColor,        // Color intermedio para contraste
                effectiveSecondaryColor,     // Color más oscuro en la base
              ],
              stops: const [0.0, 0.35, 1.0], // Transición más abrupta para un efecto más intenso
            ),
          ),
          width: double.infinity,
          height: double.infinity,
        ),
        
        // Efecto de profundidad sutil con degradado radial
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.0, -0.5),  // Centrado en la parte superior
              radius: 1.2,                         // Radio amplio
              colors: [
                Colors.white.withValues(alpha: 0.08),      // Brillo sutil
                Colors.transparent,                  // Transparente en los bordes
              ],
              stops: const [0.0, 0.6],
            ),
          ),
        ),
        
        // Elementos decorativos opcionales
        if (widget.showDecorationElements)
          Opacity(
            opacity: 0.05,
            child: CustomPaint(
              size: Size.infinite,
              painter: DecorationElementsPainter(
                color: Colors.white,
              ),
            ),
          ),
          
        // Múltiples círculos animados que rebotan por la pantalla
        if (widget.showBouncingCircle && widget.showDecorationElements)
          ..._circles.map((circle) {
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  left: MediaQuery.of(context).size.width * circle.posX - circle.radius,
                  top: MediaQuery.of(context).size.height * circle.posY - circle.radius,
                  child: Opacity(
                    opacity: circle.opacity, // Opacidad variable según el tamaño
                    child: Container(
                      width: circle.radius * 2,
                      height: circle.radius * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: circle.strokeWidth, // Grosor variable según el tamaño
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
      ],
    );
  }
}



/// Painter para añadir elementos decorativos sutiles al fondo
class DecorationElementsPainter extends CustomPainter {
  final Color color;
  
  DecorationElementsPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    // Se han eliminado todos los elementos estáticos
    // Dejando solo los elementos dinámicos (pelotas animadas)
    // para un fondo más limpio y menos cargado
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
