import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Ruta de página personalizada que implementa una transición de "Portal de Burbujas"
/// 
/// Crea una animación donde la nueva página emerge desde un círculo pequeño que
/// se expande gradualmente, similar a una burbuja que crece. Esta transición se
/// integra perfectamente con la estética de burbujas del fondo de la aplicación.
class BubblePageRoute<T> extends PageRouteBuilder<T> {
  /// Página de destino que se mostrará
  final Widget page;
  
  /// Color de la burbuja de transición
  final Color? bubbleColor;
  
  /// Duración de la animación
  final Duration duration;
  
  /// Curva de la animación
  final Curve curve;

  /// Alineación inicial del centro de la burbuja
  final Alignment alignment;
  
  /// Constructor para la ruta con transición de burbuja
  BubblePageRoute({
    required this.page,
    this.bubbleColor,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutQuint,
    this.alignment = Alignment.center,
    super.settings,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return BubbleTransition(
        animation: animation,
        curve: curve,
        alignment: alignment,
        bubbleColor: bubbleColor ?? Theme.of(context).primaryColor,
        child: child,
      );
    },
    transitionDuration: duration,
    reverseTransitionDuration: duration,
  );
}

/// Widget que implementa la transición de burbuja
class BubbleTransition extends StatefulWidget {
  final Animation<double> animation;
  final Curve curve;
  final Widget child;
  final Color bubbleColor;
  final Alignment alignment;

  const BubbleTransition({
    super.key,
    required this.animation,
    required this.curve,
    required this.child,
    required this.bubbleColor,
    required this.alignment,
  });

  @override
  State<BubbleTransition> createState() => _BubbleTransitionState();
}

class _BubbleTransitionState extends State<BubbleTransition> with SingleTickerProviderStateMixin {
  // Controlador para las micro-burbujas
  late AnimationController _microBubblesController;
  
  // Lista de micro-burbujas para el efecto adicional
  final List<MicroBubble> _microBubbles = [];
  
  @override
  void initState() {
    super.initState();
    
    // Inicializar controlador para las micro-burbujas
    _microBubblesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    // Generar micro-burbujas aleatorias
    _generateMicroBubbles();
    
    // Iniciar animación cuando comienza la transición principal
    if (widget.animation.value < 0.1) {
      _microBubblesController.forward();
    }
  }
  
  void _generateMicroBubbles() {
    final random = math.Random();
    
    // Crear 12 micro-burbujas con propiedades aleatorias
    for (int i = 0; i < 12; i++) {
      final delay = random.nextDouble() * 0.5;
      final size = random.nextDouble() * 8.0 + 4.0;
      final speed = random.nextDouble() * 0.2 + 0.1;
      
      // Posiciones aleatorias alrededor del centro
      final offsetX = (random.nextDouble() * 2 - 1) * 0.3;
      final offsetY = (random.nextDouble() * 2 - 1) * 0.3;
      
      _microBubbles.add(MicroBubble(
        delay: delay,
        size: size,
        speed: speed,
        offsetX: offsetX,
        offsetY: offsetY,
      ));
    }
  }
  
  @override
  void dispose() {
    _microBubblesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Crear una animación curva personalizada
    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: widget.animation,
      curve: widget.curve,
    );

    return Stack(
      children: [
        // Efecto de micro-burbujas (aparecen al inicio de la transición)
        if (curvedAnimation.value < 0.6) ..._buildMicroBubbles(context, curvedAnimation),
        
        // Efecto principal de portal de burbuja
        AnimatedBuilder(
          animation: curvedAnimation,
          builder: (context, child) {
            return ClipPath(
              clipper: BubbleClipper(
                progress: curvedAnimation.value,
                alignment: widget.alignment,
              ),
              child: child,
            );
          },
          child: widget.child,
        ),
      ],
    );
  }
  
  // Construye las micro-burbujas que aparecen durante la transición
  List<Widget> _buildMicroBubbles(BuildContext context, Animation<double> animation) {
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width * (widget.alignment.x * 0.5 + 0.5);
    final centerY = screenSize.height * (widget.alignment.y * 0.5 + 0.5);
    
    return _microBubbles.map((bubble) {
      // Calcular la animación con retraso para cada burbuja
      final delayedValue = math.max(0.0, math.min(1.0, 
        (animation.value - bubble.delay) / (1.0 - bubble.delay)));
      
      // Solo mostrar después del retraso y antes de que la transición principal termine
      if (delayedValue <= 0 || animation.value >= 0.9) return const SizedBox.shrink();
      
      // Calcular la posición de la burbuja
      final progress = _microBubblesController.value;
      final moveDistance = screenSize.height * bubble.speed * progress;
      
      // Posición inicial cerca del centro de la transición
      final posX = centerX + screenSize.width * bubble.offsetX;
      final posY = centerY + screenSize.height * bubble.offsetY - moveDistance;
      
      // Calcular opacidad (aparece y luego se desvanece)
      final opacity = delayedValue < 0.5 
          ? delayedValue * 2 
          : (1.0 - delayedValue) * 2;
      
      return Positioned(
        left: posX - bubble.size * 0.5,
        top: posY - bubble.size * 0.5,
        width: bubble.size * 2,
        height: bubble.size * 2,
        child: Opacity(
          opacity: opacity * 0.7,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.8),
                width: bubble.size * 0.15,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

/// Clase para representar una micro-burbuja en la animación
class MicroBubble {
  final double delay;
  final double size;
  final double speed;
  final double offsetX;
  final double offsetY;
  
  MicroBubble({
    required this.delay,
    required this.size,
    required this.speed,
    required this.offsetX,
    required this.offsetY,
  });
}

/// ClipPath personalizado que crea el efecto de portal circular expandiéndose
class BubbleClipper extends CustomClipper<Path> {
  final double progress;
  final Alignment alignment;
  
  BubbleClipper({
    required this.progress,
    required this.alignment,
  });

  @override
  Path getClip(Size size) {
    // Calcular los parámetros de la animación
    final center = Offset(
      size.width * (alignment.x * 0.5 + 0.5),
      size.height * (alignment.y * 0.5 + 0.5),
    );
    
    // Calcular el radio máximo necesario para cubrir toda la pantalla
    final maxRadius = math.sqrt(
      math.pow(math.max(center.dx, size.width - center.dx), 2) +
      math.pow(math.max(center.dy, size.height - center.dy), 2)
    );
    
    // Radio actual basado en el progreso de la animación
    // Usamos una curva personalizada para acelerar al principio y decelerar al final
    final easedProgress = progress < 0.5
        ? 4 * progress * progress * progress
        : 1 - math.pow(-2 * progress + 2, 3) / 2;
    
    final currentRadius = maxRadius * easedProgress;
    
    // Crear un círculo que crezca desde center hasta el tamaño máximo
    final path = Path()
      ..addOval(Rect.fromCircle(
        center: center,
        radius: currentRadius,
      ));
      
    return path;
  }

  @override
  bool shouldReclip(covariant BubbleClipper oldClipper) {
    return oldClipper.progress != progress || oldClipper.alignment != alignment;
  }
}

/// Extensión para facilitar el uso de la transición de burbuja
extension BubbleRouteExtension on BuildContext {
  /// Navega a una ruta con transición de burbuja usando un widget directamente
  Future<T?> pushWithBubble<T>(Widget page, {
    Color? bubbleColor,
    Duration duration = const Duration(milliseconds: 700),
    Curve curve = Curves.easeOutQuint,
    Alignment alignment = Alignment.center,
  }) {
    return Navigator.of(this).push<T>(
      BubblePageRoute<T>(
        page: page,
        bubbleColor: bubbleColor,
        duration: duration,
        curve: curve,
        alignment: alignment,
      ),
    );
  }
  
  /// Reemplaza la ruta actual con transición de burbuja usando un widget directamente
  Future<T?> pushReplacementWithBubble<T>(Widget page, {
    Color? bubbleColor,
    Duration duration = const Duration(milliseconds: 700),
    Curve curve = Curves.easeOutQuint,
    Alignment alignment = Alignment.center,
  }) {
    return Navigator.of(this).pushReplacement<T, void>(
      BubblePageRoute<T>(
        page: page,
        bubbleColor: bubbleColor,
        duration: duration,
        curve: curve,
        alignment: alignment,
      ),
    );
  }
}
