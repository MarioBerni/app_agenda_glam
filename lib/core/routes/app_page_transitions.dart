import 'dart:math' as math;
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Tipo de transición para cada ruta
enum TransitionType {
  /// Transición por defecto - Fade + Slide desde abajo
  defaultTransition,

  /// Transición para entrar a pantallas de autenticación - Fade + Slide desde la derecha
  authForward,

  /// Transición para volver atrás en autenticación - Fade + Slide desde la izquierda
  authBackward,

  /// Transición para confirmaciones - Fade + Scale
  confirmation,

  /// Transición para pantallas de perfil - Slide horizontal
  profile,

  /// Transición fade para cambios sutiles
  fade,
  
  /// Transición circular expandiéndose desde la esquina inferior izquierda (avanzar)
  circleForward,
  
  /// Transición circular expandiéndose desde la esquina inferior derecha (retroceder)
  circleBackward,
}

/// Define las transiciones personalizadas para las páginas de la aplicación
/// siguiendo la identidad visual de Agenda Glam
class AppPageTransitions {
  // Prevenir instanciación
  AppPageTransitions._();

  /// Mapa de transiciones predefinidas (se puede expandir según necesidad)
  static final Map<String, TransitionType> _routeTransitions = {
    // Autenticación
    '/welcome': TransitionType.circleForward,
    '/login': TransitionType.circleForward,
    '/register': TransitionType.circleForward,
    '/recovery': TransitionType.circleForward,

    // Confirmaciones
    '/recovery/confirmation': TransitionType.confirmation,

    // Principal
    '/': TransitionType.circleForward,
  };
  
  /// Mapa que define las transiciones para navegación hacia atrás
  static final Map<String, TransitionType> _reverseTransitions = {
    // Usar transición circular hacia atrás al regresar de estas rutas
    '/login': TransitionType.circleBackward,
    '/register': TransitionType.circleBackward,
    '/recovery': TransitionType.circleBackward,
    '/': TransitionType.circleBackward,
  };

  /// Obtiene el tipo de transición para una ruta específica
  static TransitionType getTransitionType(String routePath, {bool isReverse = false}) {
    if (isReverse) {
      return _reverseTransitions[routePath] ?? TransitionType.circleBackward;
    }
    return _routeTransitions[routePath] ?? TransitionType.circleForward;
  }

  /// Crea una página con transición personalizada basada en la ruta y dirección
  static CustomTransitionPage<void> buildTransitionPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    TransitionType? transitionType,
    bool isReverse = false,
  }) {
    // Determinar tipo de transición
    final effectiveTransitionType =
        transitionType ?? getTransitionType(state.uri.path, isReverse: isReverse);

    // Crear transición basada en el tipo
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _buildTransition(
          context: context,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
          type: effectiveTransitionType,
        );
      },
      transitionDuration: _getTransitionDuration(effectiveTransitionType),
      reverseTransitionDuration: _getTransitionDuration(
        effectiveTransitionType,
      ),
    );
  }

  /// Construye la transición específica basada en el tipo
  static Widget _buildTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
    required TransitionType type,
  }) {
    // Curva de animación
    final curve = CurvedAnimation(
      parent: animation,
      curve: GlamAnimations.defaultCurve,
    );

    switch (type) {
      case TransitionType.defaultTransition:
        // Fade + Slide desde abajo
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          ),
        );

      case TransitionType.authForward:
        // Fade + Slide desde la derecha
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.08, 0),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          ),
        );

      case TransitionType.authBackward:
        // Fade + Slide desde la izquierda
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-0.08, 0),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          ),
        );

      case TransitionType.confirmation:
        // Fade + Scale para confirmaciones
        return FadeTransition(
          opacity: curve,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutQuint),
            ),
            child: child,
          ),
        );

      case TransitionType.profile:
        // Slide horizontal para perfil
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curve),
          child: child,
        );

      case TransitionType.fade:
        // Transición fade simple
        return FadeTransition(opacity: curve, child: child);
        
      case TransitionType.circleForward:
        // Transición circular desde esquina inferior izquierda
        return _buildCircleTransition(
          animation: animation,
          child: child,
          alignment: Alignment.bottomLeft,
        );
      
      case TransitionType.circleBackward:
        // Transición circular desde esquina inferior derecha
        return _buildCircleTransition(
          animation: animation,
          child: child,
          alignment: Alignment.bottomRight,
        );
    }
  }

  /// Determina la duración de la transición según el tipo
  static Duration _getTransitionDuration(TransitionType type) {
    switch (type) {
      case TransitionType.defaultTransition:
      case TransitionType.authForward:
      case TransitionType.authBackward:
        return const Duration(milliseconds: 350);
      case TransitionType.confirmation:
        return const Duration(milliseconds: 400);
      case TransitionType.profile:
        return const Duration(milliseconds: 300);
      case TransitionType.fade:
        return const Duration(milliseconds: 250);
      case TransitionType.circleForward:
      case TransitionType.circleBackward:
        return const Duration(milliseconds: 1200);
    }
  }
  
  /// Construye una transición circular con la alineación especificada
  static Widget _buildCircleTransition({
    required Animation<double> animation,
    required Widget child,
    required Alignment alignment,
  }) {
    return Stack(
      children: [
        // Fondo común que permanece visible durante toda la transición
        const GlamGradientBackground(),
        
        // La página nueva con el efecto de círculo
        ClipPath(
          clipper: _CircleRevealClipper(
            fraction: animation.value,
            alignment: alignment,
          ),
          child: child,
        ),
      ],
    );
  }
}

/// Clipper que crea un círculo que se expande para la transición
class _CircleRevealClipper extends CustomClipper<Path> {
  /// Valor entre 0.0 y 1.0 que indica cuánto del círculo se ha revelado
  final double fraction;
  
  /// Alineación del centro del círculo
  final Alignment alignment;
  
  _CircleRevealClipper({
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
  bool shouldReclip(_CircleRevealClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.alignment != alignment;
  }
}
