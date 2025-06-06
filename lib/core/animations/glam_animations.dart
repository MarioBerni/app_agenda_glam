import 'package:flutter/material.dart';

/// Clase de utilidades de animación para la aplicación Agenda Glam
/// Proporciona métodos estáticos para aplicar efectos de animación
/// consistentes en toda la aplicación.
class GlamAnimations {
  /// Aplica un efecto de entrada con animación a un widget
  /// 
  /// [child] - El widget al que se aplicará la animación
  /// [duration] - Duración de la animación (por defecto 500ms)
  /// [curve] - Curva de animación (por defecto Curves.easeOut)
  /// [delay] - Retraso antes de iniciar la animación (por defecto 0ms)
  static Widget applyEntryEffect(
    Widget child, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    Duration delay = Duration.zero,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  /// Aplica un efecto de pulso a un widget
  /// 
  /// [child] - El widget al que se aplicará la animación
  /// [duration] - Duración de un ciclo de pulso (por defecto 1500ms)
  /// [minScale] - Escala mínima durante el pulso (por defecto 0.95)
  /// [maxScale] - Escala máxima durante el pulso (por defecto 1.05)
  static Widget applyPulseEffect(
    Widget child, {
    Duration duration = const Duration(milliseconds: 1500),
    double minScale = 0.95,
    double maxScale = 1.05,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: minScale, end: maxScale),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
      onEnd: () {},
    );
  }

  /// Aplica un efecto de desvanecimiento entre dos widgets
  /// 
  /// [child] - El widget actual
  /// [previousChild] - El widget anterior (que se desvanecerá)
  /// [duration] - Duración de la transición (por defecto 300ms)
  static Widget applyFadeTransition(
    Widget child,
    Widget? previousChild, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Aplica un efecto de rebote a un widget
  /// 
  /// [child] - El widget al que se aplicará la animación
  /// [duration] - Duración del rebote (por defecto 300ms)
  /// [magnitude] - Magnitud del rebote (por defecto 0.1)
  static Widget applyBounceEffect(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    double magnitude = 0.1,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.elasticOut,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: 1 + (magnitude * (value - 1)),
          child: child,
        );
      },
      child: child,
    );
  }

  /// Aplica un efecto de deslizamiento a un widget
  /// 
  /// [child] - El widget al que se aplicará la animación
  /// [duration] - Duración de la animación (por defecto 500ms)
  /// [offset] - Desplazamiento inicial (por defecto 100.0 horizontalmente)
  /// [curve] - Curva de la animación (por defecto Curves.easeOutCubic)
  static Widget applySlideEffect(
    Widget child, {
    Duration duration = const Duration(milliseconds: 500),
    Offset offset = const Offset(100.0, 0.0),
    Curve curve = Curves.easeOutCubic,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(
            offset.dx * (1 - value),
            offset.dy * (1 - value),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}
