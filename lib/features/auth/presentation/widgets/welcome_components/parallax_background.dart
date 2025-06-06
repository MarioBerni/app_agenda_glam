import 'package:flutter/material.dart';

/// Controlador para animar efectos parallax
class ParallaxController extends ChangeNotifier {
  double _dx = 0.0;
  double _dy = 0.0;
  
  double get dx => _dx;
  double get dy => _dy;
  
  void updateOffset(double dx, double dy) {
    _dx = dx;
    _dy = dy;
    notifyListeners();
  }
  

}

/// Widget para crear un efecto parallax en el fondo con animación mejorada
class ParallaxBackground extends StatelessWidget {
  final Widget child;
  final ParallaxController controller;

  const ParallaxBackground({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(controller.dx * 25, controller.dy * 25), // Efecto más pronunciado
          child: child,
        );
      },
    );
  }
}
