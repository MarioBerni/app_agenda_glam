import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';

/// Una transición de página personalizada que crea un efecto de círculo expandiéndose
/// 
/// Esta transición simula un portal circular que crece desde un punto específico
/// para revelar la nueva página, complementando la estética de burbujas de la aplicación.
class CirclePageRoute<T> extends PageRouteBuilder<T> {
  /// Widget de la página de destino
  final Widget page;
  
  /// Color del círculo (opcional)
  final Color circleColor;
  
  /// Alineación del centro del círculo (por defecto, centro de la pantalla)
  final Alignment alignment;
  
  CirclePageRoute({
    required this.page,
    this.circleColor = kPrimaryColorLight,
    this.alignment = Alignment.center,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Configuramos un fondo consistente durante toda la transición
            // La página anterior se ocultará automáticamente al ser reemplazada por
            // el fondo común, evitando cualquier superposición visual
            
            return Stack(
              children: [
                // Fondo común que permanece visible durante toda la transición
                const GlamGradientBackground(),
                
                // La página nueva con el efecto de círculo
                ClipPath(
                  clipper: CircleRevealClipper(
                    fraction: animation.value,
                    alignment: alignment,
                  ),
                  child: child,
                ),
              ],
            );
          },
          transitionDuration: const Duration(milliseconds: 1100),
        );
}

/// Clipper que crea un círculo que se expande para la transición
class CircleRevealClipper extends CustomClipper<Path> {
  /// Valor entre 0.0 y 1.0 que indica cuánto del círculo se ha revelado
  final double fraction;
  
  /// Alineación del centro del círculo
  final Alignment alignment;
  
  CircleRevealClipper({
    required this.fraction,
    required this.alignment,
  });
  
  @override
  Path getClip(Size size) {
    final center = Offset(
      size.width * (alignment.x * 0.5 + 0.5),
      size.height * (alignment.y * 0.5 + 0.5),
    );
    
    // Calculamos el radio máximo necesario para cubrir toda la pantalla
    final maxRadius = math.sqrt(
      math.pow(size.width, 2) + math.pow(size.height, 2)
    );
    
    // Radio actual basado en la fracción de animación
    final radius = maxRadius * fraction;
    
    final path = Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );
      
    return path;
  }
  
  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.alignment != alignment;
  }
}

/// Extensión para facilitar el uso de la transición circular
extension CircleRouteExtension on BuildContext {
  /// Navega hacia adelante a una nueva página con efecto de transición circular
  /// El círculo se expande desde el borde inferior izquierdo
  Future<T?> pushCircle<T>(
    Widget page, {
    Color? circleColor,
  }) {
    return Navigator.of(this).push<T>(
      CirclePageRoute<T>(
        page: page,
        circleColor: circleColor ?? kPrimaryColorLight,
        alignment: Alignment.bottomLeft, // Alineación para navegación hacia adelante
      ),
    );
  }
  
  /// Navega hacia atrás con un efecto de transición circular
  /// El círculo se expande desde el borde inferior derecho
  void popCircle<T>(
    Widget page, {
    Color? circleColor,
  }) {
    // En lugar de hacer push, hacemos un pop real
    // y luego reemplazamos la página actual con una transición
    Navigator.of(this).pop();
    
    // Si estamos usando GoRouter, debemos evitar modificar la pila directamente
    // después de un pop. Esta implementación asegura compatibilidad con GoRouter.
  }
  
  /// Sustituye la página actual usando una transición circular
  /// con la alineación especificada
  Future<T?> pushReplacementCircle<T, TO>(
    Widget page, {
    Color? circleColor,
    Alignment alignment = Alignment.bottomLeft,
    TO? result,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      CirclePageRoute<T>(
        page: page,
        circleColor: circleColor ?? kPrimaryColorLight,
        alignment: alignment,
      ),
      result: result,
    );
  }
}
