import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';

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
/// y elementos diagonales para toda la aplicación.
///
/// Este componente implementa el fondo estándar mejorado de Agenda Glam,
/// con degradados sofisticados y elementos visuales diagonales que
/// mantienen la estética masculina y elegante definida en el tema.
class GlamGradientBackground extends StatefulWidget {
  /// Color primario para el degradado.
  /// Si no se especifica, usa kPrimaryColor del tema.
  final Color? primaryColor;
  
  /// Color secundario para el degradado.
  /// Si no se especifica, se calcula a partir del color primario.
  final Color? secondaryColor;
  
  /// Color para la franja diagonal.
  /// Si no se especifica, usa el kAccentColor del tema.
  final Color? accentColor;
  
  /// Opacidad del degradado (0.0 - 1.0).
  final double opacity;
  
  /// Ancho de la franja diagonal como porcentaje del ancho de la pantalla.
  final double diagonalStripWidth;
  
  /// Ángulo de inclinación de la franja diagonal en grados.
  final double diagonalAngle;
  
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
    this.diagonalStripWidth = 0.25, // 25% del ancho de pantalla
    this.diagonalAngle = 60, // 60 grados (mayor inclinación)
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
    // Determinar colores principales
    final Color effectivePrimaryColor = widget.primaryColor ?? kPrimaryColor;
    final Color effectiveSecondaryColor = widget.secondaryColor ?? 
        kBackgroundColor.withValues(alpha: widget.opacity);
    // Usamos un color azul más claro que armonice con el degradado en lugar del dorado
    final Color effectiveAccentColor = widget.accentColor ?? 
        kPrimaryColorLight.withValues(alpha: 0.25); // Usando un azul más claro de la paleta
    
    return Stack(
      children: [
        // Degradado de fondo mejorado
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                effectivePrimaryColor,
                effectivePrimaryColor.withValues(alpha: 0.85),
                effectiveSecondaryColor,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
          width: double.infinity,
          height: double.infinity,
        ),
        
        // Franja diagonal
        CustomPaint(
          size: Size.infinite,
          painter: DiagonalStripPainter(
            stripColor: effectiveAccentColor,
            stripWidth: widget.diagonalStripWidth,
            angle: widget.diagonalAngle,
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

/// Painter personalizado para dibujar la franja diagonal
class DiagonalStripPainter extends CustomPainter {
  final Color stripColor;
  final double stripWidth;
  final double angle;
  
  DiagonalStripPainter({
    required this.stripColor,
    required this.stripWidth,
    required this.angle,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = stripColor
      ..style = PaintingStyle.fill;
      
    // Calcular puntos para la franja diagonal
    final path = Path();
    
    // Nota: El ángulo proporcionado como parámetro determina
    // la inclinación visual de la franja diagonal, aunque no
    // lo usemos para cálculos específicos en esta implementación
    
    // Crear un path para la franja diagonal con mayor inclinación
    path.moveTo(size.width * 0.4, 0); // Movido más a la izquierda para aumentar la inclinación
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.2, size.height); // Mayor inclinación
    path.lineTo(0, size.height * 0.7); // Ajustado para una línea más diagonal
    path.close();
    
    canvas.drawPath(path, paint);
    
    // Añadir un segundo path con degradado para efecto de profundidad sutil
    // Usando colores de la misma familia de azules para mejor integración
    final gradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        // Usando colores de la paleta azul que armonicen con el fondo
        kPrimaryColor.withValues(alpha: 0.3),
        kPrimaryColorDark.withValues(alpha: 0.05),
      ],
    );
    
    final secondPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(
        size.width * 0.5, // Ajustado para la nueva posición
        0,
        size.width * 0.5, 
        size.height,
      ));
    
    path.reset();
    path.moveTo(size.width * 0.45, 0);    // Ajustado para mayor inclinación
    path.lineTo(size.width * 0.8, 0);     // No abarca todo el ancho superior
    path.lineTo(size.width * 0.3, size.height); // Mayor inclinación
    path.lineTo(0, size.height * 0.5);    // Punto inferior ajustado
    path.close();
    
    canvas.drawPath(path, secondPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
