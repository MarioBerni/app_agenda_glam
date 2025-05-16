import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Botón personalizado con el estilo de Agenda Glam
/// Soporta estados de carga, deshabilitado, iconos y efectos visuales
class GlamButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final bool isSecondary;
  final IconData? icon;
  final bool withShimmer;
  final bool withRippleEffect;

  const GlamButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = 50,
    this.isSecondary = false,
    this.icon,
    this.withShimmer = false,
    this.withRippleEffect = true,
  });

  @override
  State<GlamButton> createState() => _GlamButtonState();
}

class _GlamButtonState extends State<GlamButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.withShimmer) {
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
    final accentColor = theme.colorScheme.secondary;
    final textColor = widget.isSecondary ? accentColor : Colors.black;

    // Calcular tamaños y sombras basados en estado
    final scale = _isPressed ? 0.98 : (_isHovered ? 1.02 : 1.0);
    final elevation =
        widget.isSecondary
            ? 0.0
            : (_isHovered ? 4.0 : (_isPressed ? 1.0 : 2.0));
    final shadowOpacity =
        widget.isSecondary
            ? 0.0
            : (_isHovered ? 0.4 : (_isPressed ? 0.2 : 0.3));

    // Construir el contenido del botón
    Widget buttonContent = isLoadingOrContent(textColor, theme);

    // Aplicar efecto shimmer si está habilitado
    if (widget.withShimmer && !widget.isLoading) {
      buttonContent = AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) {
          return ShimmerEffect(
            active: widget.withShimmer && !widget.isLoading,
            direction: _shimmerAnimation.value,
            child: child!,
          );
        },
        child: buttonContent,
      );
    }

    return SizedBox(
      width: widget.isFullWidth ? double.infinity : null,
      height: widget.height,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedScale(
            scale: widget.isLoading ? 1.0 : scale,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: widget.isSecondary ? Colors.transparent : accentColor,
                borderRadius: BorderRadius.circular(12),
                border:
                    widget.isSecondary
                        ? Border.all(color: accentColor, width: 2)
                        : null,
                boxShadow: [
                  if (!widget.isSecondary)
                    BoxShadow(
                      color: accentColor.withValues(alpha: shadowOpacity),
                      blurRadius: elevation * 2,
                      spreadRadius: elevation / 2,
                      offset: Offset(0, elevation / 2),
                    ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.isLoading ? null : widget.onPressed,
                  borderRadius: BorderRadius.circular(12),
                  splashColor:
                      widget.withRippleEffect
                          ? (widget.isSecondary
                              ? accentColor.withValues(alpha: 0.1)
                              : Colors.white.withValues(alpha: 0.1))
                          : Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    child: Center(child: buttonContent),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget isLoadingOrContent(Color textColor, ThemeData theme) {
    if (widget.isLoading) {
      // Estado de carga
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    } else if (widget.icon != null) {
      // Con icono
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, color: textColor, size: 20),
          const SizedBox(width: 8),
          Text(
            widget.text,
            style: theme.textTheme.labelLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      );
    } else {
      // Solo texto
      return Text(
        widget.text,
        style: theme.textTheme.labelLarge?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      );
    }
  }
}

/// Widget que aplica un efecto de shimmer (brillo deslizante) a sus hijos
class ShimmerEffect extends StatelessWidget {
  final Widget child;
  final bool active;
  final double direction;

  const ShimmerEffect({
    super.key,
    required this.child,
    this.active = true,
    this.direction = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    if (!active) return child;

    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment(math.max(-1, math.min(direction, 2)), 0.0),
          end: Alignment(math.min(2, math.max(direction + 1, -1)), 0.0),
          colors: const [Colors.transparent, Colors.white, Colors.transparent],
          stops: const [0.4, 0.5, 0.6],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: child,
    );
  }
}
