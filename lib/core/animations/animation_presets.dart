import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';

/// Conjunto de presets de animación para Agenda Glam siguiendo
/// el estilo minimalista, elegante y masculino de la aplicación.
class GlamAnimations {
  // Prevenir instanciación
  GlamAnimations._();

  // Duración estándar para animaciones
  static const Duration defaultDuration = Duration(milliseconds: 600);
  static const Duration shortDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 1200);

  // Curvas preferidas para las animaciones de la app
  static const Curve defaultCurve = Curves.easeOutQuad;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve sharpCurve = Curves.easeOutCubic;

  /// Aplica animaciones de entrada a un widget usando el método extension
  static Widget applyEntryEffect(
    Widget widget, {
    Duration? duration,
    double slideDistance = 0.1,
    double initialScale = 0.95,
  }) {
    return widget
        .animate()
        .fade(duration: duration ?? defaultDuration, curve: defaultCurve)
        .slide(
          begin: Offset(0, slideDistance),
          end: Offset.zero,
          duration: duration ?? defaultDuration,
          curve: defaultCurve,
        )
        .custom(
          duration: duration ?? defaultDuration,
          curve: bounceCurve,
          builder:
              (context, value, child) => Transform.scale(
                scale: initialScale + (1.0 - initialScale) * value,
                child: child,
              ),
        );
  }

  /// Aplica efecto de presión a un botón
  static Widget applyButtonPressEffect(
    Widget widget, {
    bool isPressed = false,
  }) {
    return widget
        .animate(target: isPressed ? 1 : 0)
        .custom(
          duration: shortDuration,
          curve: Curves.easeInOut,
          builder:
              (context, value, child) => Transform.scale(
                scale: isPressed ? (1.0 - 0.05 * value) : (0.95 + 0.05 * value),
                child: child,
              ),
        );
  }

  /// Aplica efecto de shimmer a un widget
  static Widget applyShimmerEffect(
    Widget widget, {
    Duration? duration,
    Color? color,
  }) {
    return widget.animate().shimmer(
      duration: duration ?? longDuration,
      color:
          color ??
          Color.fromRGBO(
            kAccentColor.r.toInt(),
            kAccentColor.g.toInt(),
            kAccentColor.b.toInt(),
            0.5,
          ),
      delay: const Duration(milliseconds: 500),
    );
  }

  /// Aplica efecto de error (shake) a un widget
  static Widget applyErrorEffect(Widget widget) {
    return widget.animate().shake(
      duration: const Duration(milliseconds: 400),
      hz: 4,
      offset: const Offset(5, 0),
    );
  }

  /// Aplica efecto de éxito a un widget
  static Widget applySuccessEffect(Widget widget) {
    return widget.animate().custom(
      duration: shortDuration,
      curve: Curves.elasticOut,
      builder:
          (context, value, child) =>
              Transform.scale(scale: 0.8 + 0.2 * value, child: child),
    );
  }

  /// Animación especial para el logo
  static Widget applyLogoEffect(Widget widget) {
    return widget
        .animate()
        .custom(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          builder:
              (context, value, child) =>
                  Transform.scale(scale: value, child: child),
        )
        .fade(
          begin: 0.0,
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuad,
        )
        .shimmer(
          delay: const Duration(milliseconds: 1200),
          duration: const Duration(milliseconds: 1800),
          color: Color.fromRGBO(
            kAccentColor.r.toInt(),
            kAccentColor.g.toInt(),
            kAccentColor.b.toInt(),
            0.7,
          ),
        );
  }

  /// Transición de página elegante acorde a la identidad de la marca
  static Widget pageTransition({
    required Widget child,
    required Animation<double> animation,
    Offset? beginOffset,
  }) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutQuad),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset ?? const Offset(0.0, 0.05),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOutQuad),
          ),
        ),
        child: child,
      ),
    );
  }
}

/// Extensiones para facilitar el uso de las animaciones en widgets
extension GlamAnimateExtension on Widget {
  Widget glamEntry({Duration? duration, Offset? offset, double? scale}) {
    final effectiveScale = scale ?? 0.95;
    final effectiveOffset = offset ?? const Offset(0, 0.1);

    return animate()
        .fade(
          duration: duration ?? GlamAnimations.defaultDuration,
          curve: GlamAnimations.defaultCurve,
          begin: 0.0,
          end: 1.0,
        )
        .slide(
          duration: duration ?? GlamAnimations.defaultDuration,
          curve: GlamAnimations.defaultCurve,
          begin: effectiveOffset,
          end: Offset.zero,
        )
        .custom(
          duration: duration ?? GlamAnimations.defaultDuration,
          curve: GlamAnimations.bounceCurve,
          builder:
              (context, value, child) => Transform.scale(
                scale: effectiveScale + (1.0 - effectiveScale) * value,
                child: child,
              ),
        );
  }

  Widget glamButton({bool isPressed = false}) {
    return animate(target: isPressed ? 1.0 : 0.0).custom(
      duration: GlamAnimations.shortDuration,
      curve: Curves.easeInOut,
      builder:
          (context, value, child) => Transform.scale(
            scale: isPressed ? (1.0 - 0.05 * value) : (0.95 + 0.05 * value),
            child: child,
          ),
    );
  }

  Widget glamShimmer({Duration? duration, Color? color}) {
    return animate().shimmer(
      delay: const Duration(milliseconds: 500),
      duration: duration ?? GlamAnimations.longDuration,
      color:
          color ??
          Color.fromRGBO(
            kAccentColor.r.toInt(),
            kAccentColor.g.toInt(),
            kAccentColor.b.toInt(),
            0.5,
          ),
    );
  }

  Widget glamLogo() {
    return animate()
        .custom(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          builder:
              (context, value, child) =>
                  Transform.scale(scale: value, child: child),
        )
        .fade(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 600),
          begin: 0.0,
          end: 1.0,
          curve: Curves.easeOutQuad,
        )
        .shimmer(
          delay: const Duration(milliseconds: 1200),
          duration: const Duration(milliseconds: 1800),
          color: Color.fromRGBO(
            kAccentColor.r.toInt(),
            kAccentColor.g.toInt(),
            kAccentColor.b.toInt(),
            0.7,
          ),
        );
  }

  Widget glamError() {
    return animate().shake(
      duration: const Duration(milliseconds: 400),
      hz: 4,
      offset: const Offset(5, 0),
    );
  }

  Widget glamSuccess() {
    return animate().custom(
      duration: GlamAnimations.shortDuration,
      curve: Curves.elasticOut,
      builder:
          (context, value, child) =>
              Transform.scale(scale: 0.8 + 0.2 * value, child: child),
    );
  }
}
