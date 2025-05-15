// No necesitamos importar animation_presets directamente ya que usamos Flutter Animate
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// BotÃ³n estilizado con animaciones y efectos visuales consistentes
///
/// Proporciona un botÃ³n con estilo visual unificado para toda la aplicaciÃ³n,
/// incluyendo animaciones, efectos de presiÃ³n y estados de carga.
class GlamButton extends StatefulWidget {
  /// Texto del botÃ³n
  final String text;

  /// FunciÃ³n al presionar el botÃ³n
  final VoidCallback? onPressed;

  /// Icono del botÃ³n (opcional)
  final IconData? icon;

  /// Estado de carga
  final bool isLoading;

  /// Variante del botÃ³n (primary, secondary, text)
  final GlamButtonVariant variant;

  /// TamaÃ±o del botÃ³n
  final GlamButtonSize size;

  /// Si debe expandirse al ancho disponible
  final bool expanded;

  /// Bordes redondeados personalizados
  final BorderRadius? borderRadius;

  /// Si debe aplicar animaciÃ³n de entrada
  final bool animateEntry;

  /// Color principal personalizado
  final Color? primaryColor;

  /// Constructor
  const GlamButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.variant = GlamButtonVariant.primary,
    this.size = GlamButtonSize.medium,
    this.expanded = true,
    this.borderRadius,
    this.animateEntry = true,
    this.primaryColor,
  });

  @override
  State<GlamButton> createState() => _GlamButtonState();
}

class _GlamButtonState extends State<GlamButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _loadingController;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.isLoading) {
      _loadingController.repeat();
    }
  }

  @override
  void didUpdateWidget(GlamButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _loadingController.repeat();
      } else {
        _loadingController.stop();
      }
    }
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Configurar segÃºn la variante y tamaÃ±o
    final colors = _getColorsForVariant();
    final padding = _getPaddingForSize();
    final textStyle = _getTextStyleForSize();
    final buttonRadius = widget.borderRadius ?? BorderRadius.circular(8.0);

    // Construir el botÃ³n base
    Widget buttonChild = Ink(
      decoration: BoxDecoration(
        color:
            widget.onPressed != null
                ? colors.background
                : colors.background.withValues(alpha: 0.5),
        borderRadius: buttonRadius,
        gradient:
            widget.variant == GlamButtonVariant.primary &&
                    widget.onPressed != null
                ? LinearGradient(
                  colors: [
                    widget.primaryColor ?? kPrimaryColor,
                    Color.lerp(
                          widget.primaryColor ?? kPrimaryColor,
                          kAccentColor,
                          0.6,
                        ) ??
                        kAccentColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
        boxShadow:
            widget.variant == GlamButtonVariant.primary &&
                    widget.onPressed != null
                ? [
                  BoxShadow(
                    color: (widget.primaryColor ?? kPrimaryColor).withValues(
                      alpha: 0.3,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
                : null,
      ),
      child: InkWell(
        onTap: widget.isLoading ? null : widget.onPressed,
        borderRadius: buttonRadius,
        onHighlightChanged: (isPressed) {
          setState(() {
            _isPressed = isPressed;
          });
        },
        highlightColor: colors.splash,
        splashColor: colors.splash,
        child: Container(
          padding: padding,
          width: widget.expanded ? double.infinity : null,
          child: Row(
            mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Estado de carga
              if (widget.isLoading)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                    width: widget.size == GlamButtonSize.small ? 16 : 20,
                    height: widget.size == GlamButtonSize.small ? 16 : 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(colors.text),
                    ),
                  ),
                )
              // Icono si existe
              else if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    widget.icon,
                    color: colors.text,
                    size: widget.size == GlamButtonSize.small ? 16 : 20,
                  ),
                ),

              // Texto del botÃ³n
              Text(
                widget.text,
                style: textStyle.copyWith(color: colors.text),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    // Aplicar efecto de presiÃ³n
    buttonChild = AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: buttonChild,
    );

    // Aplicar animaciÃ³n de entrada si estÃ¡ habilitada
    if (widget.animateEntry) {
      buttonChild = buttonChild
          .animate()
          .fadeIn(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          )
          .slideY(
            begin: 0.2,
            end: 0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
          );
    }

    return buttonChild;
  }

  /// Obtiene los colores segÃºn la variante del botÃ³n
  _ButtonColors _getColorsForVariant() {
    final isEnabled = widget.onPressed != null;

    switch (widget.variant) {
      case GlamButtonVariant.primary:
        return _ButtonColors(
          background: widget.primaryColor ?? kPrimaryColor,
          text: Colors.white,
          splash: Colors.white.withValues(alpha: 0.1),
        );

      case GlamButtonVariant.secondary:
        return _ButtonColors(
          background: Colors.white.withValues(alpha: 0.1),
          text: Colors.white,
          splash: Colors.white.withValues(alpha: 0.05),
        );

      case GlamButtonVariant.text:
        return _ButtonColors(
          background: Colors.transparent,
          text:
              isEnabled
                  ? (widget.primaryColor ?? kAccentColor)
                  : Colors.white.withValues(alpha: 0.5),
          splash: (widget.primaryColor ?? kAccentColor).withValues(alpha: 0.1),
        );
    }
  }

  /// Obtiene el padding segÃºn el tamaÃ±o del botÃ³n
  EdgeInsets _getPaddingForSize() {
    switch (widget.size) {
      case GlamButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case GlamButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case GlamButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  /// Obtiene el estilo de texto segÃºn el tamaÃ±o del botÃ³n
  TextStyle _getTextStyleForSize() {
    switch (widget.size) {
      case GlamButtonSize.small:
        return const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
      case GlamButtonSize.medium:
        return const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
      case GlamButtonSize.large:
        return const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    }
  }
}

/// Variantes de estilo para el botÃ³n
enum GlamButtonVariant {
  /// BotÃ³n principal con fondo de color y gradiente
  primary,

  /// BotÃ³n secundario con fondo semitransparente
  secondary,

  /// BotÃ³n de texto sin fondo
  text,
}

/// TamaÃ±os predefinidos para el botÃ³n
enum GlamButtonSize {
  /// BotÃ³n pequeÃ±o
  small,

  /// BotÃ³n mediano (por defecto)
  medium,

  /// BotÃ³n grande
  large,
}

/// Clase auxiliar para manejar los colores del botÃ³n
class _ButtonColors {
  final Color background;
  final Color text;
  final Color splash;

  _ButtonColors({
    required this.background,
    required this.text,
    required this.splash,
  });
}
