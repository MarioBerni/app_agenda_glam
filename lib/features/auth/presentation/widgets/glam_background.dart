import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';

/// Widget que proporciona un fondo elegante y dinámico con
/// degradados, formas geométricas y efectos de parallax sutiles.
/// 
/// @deprecated Este componente está obsoleto y será eliminado en versiones futuras.
/// Utilizar el nuevo componente centralizado [GlamGradientBackground] en su lugar.
class GlamBackground extends StatefulWidget {
  /// El color primario del gradiente
  final Color? primaryColor;

  /// El color secundario del gradiente
  final Color? secondaryColor;

  /// Determina si el fondo tendrá un efecto de movimiento
  final bool animate;

  /// La opacidad de los elementos decorativos
  final double decorationOpacity;

  /// La densidad de elementos decorativos (formas geométricas)
  final double decorationDensity;

  /// La intensidad general de los efectos visuales
  final double intensity;

  const GlamBackground({
    super.key,
    this.primaryColor,
    this.secondaryColor,
    this.animate = true,
    this.decorationOpacity = 0.15,
    this.decorationDensity = 0.8,
    this.intensity = 1.0,
  });

  @override
  State<GlamBackground> createState() => _GlamBackgroundState();
}

class _GlamBackgroundState extends State<GlamBackground> {
  @override
  Widget build(BuildContext context) {
    // Simplemente delegar al nuevo componente centralizado
    return GlamGradientBackground(
      primaryColor: widget.primaryColor ?? kPrimaryColor,
      secondaryColor: widget.secondaryColor,
      opacity: widget.intensity,
    );
  }
}
