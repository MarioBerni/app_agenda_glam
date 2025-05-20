import 'package:app_agenda_glam/core/animations/animation_presets.dart';
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
}

/// Define las transiciones personalizadas para las páginas de la aplicación
/// siguiendo la identidad visual de Agenda Glam
class AppPageTransitions {
  // Prevenir instanciación
  AppPageTransitions._();

  /// Mapa de transiciones predefinidas (se puede expandir según necesidad)
  static final Map<String, TransitionType> _routeTransitions = {
    // Autenticación
    '/welcome': TransitionType.defaultTransition,
    '/login': TransitionType.authForward,
    '/register': TransitionType.authForward,
    '/recovery': TransitionType.authForward,

    // Confirmaciones
    '/recovery/confirmation': TransitionType.confirmation,

    // Principal
    '/': TransitionType.fade,
  };

  /// Obtiene el tipo de transición para una ruta específica
  static TransitionType getTransitionType(String routePath) {
    return _routeTransitions[routePath] ?? TransitionType.defaultTransition;
  }

  /// Crea una página con transición personalizada basada en la ruta y dirección
  static CustomTransitionPage<void> buildTransitionPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    TransitionType? transitionType,
  }) {
    // Determinar tipo de transición
    final effectiveTransitionType =
        transitionType ?? getTransitionType(state.uri.path);

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
    }
  }
}
