import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';

/// Widget que muestra el texto informativo y los botones de inicio de sesión y registro
class ActionCard extends StatelessWidget {
  final ParallaxController parallaxController;
  
  const ActionCard({
    super.key,
    required this.parallaxController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título con animación
        GlamAnimations.applyEntryEffect(
          const Text(
            'Comienza tu experiencia',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          slideDistance: 0.1,
        ),
        
        const SizedBox(height: 8),
        
        // Texto descriptivo
        GlamAnimations.applyEntryEffect(
          Text(
            'Accede a todas las funcionalidades y reserva tu próxima cita de estética masculina',
            style: TextStyle(
              fontSize: 14,
              color: ColorUtils.withOpacityValue(Colors.white, 0.8),
            ),
          ),
          slideDistance: 0.15,
        ),
        
        const SizedBox(height: 24),
        
        // Botones de inicio de sesión y registro
        _buildLoginButton(context),
        
        const SizedBox(height: 16),
        
        _buildRegisterButton(context),
      ],
    );
  }
  
  /// Construye el botón de inicio de sesión con animación y transición
  Widget _buildLoginButton(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Hero(
        tag: 'login_button',
        child: GlamButton(
          text: 'Iniciar Sesión',
          onPressed: () async {
            parallaxController.animateForward();
            final navigatorState = Navigator.of(context);
            final themeData = Theme.of(context);
            
            await Future.delayed(const Duration(milliseconds: 300));
            
            if (navigatorState.mounted) {
              CircleNavigation.goToLoginWithState(navigatorState, themeData);
            }
          },
          icon: Icons.login_rounded,
          withShimmer: true,
        ),
      ),
      slideDistance: 0.2,
    );
  }
  
  /// Construye el botón de registro con animación y transición
  Widget _buildRegisterButton(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Hero(
        tag: 'register_button',
        child: GlamButton(
          text: 'Registrarse',
          onPressed: () async {
            parallaxController.animateForward();
            final navigatorState = Navigator.of(context);
            final themeData = Theme.of(context);
            
            await Future.delayed(const Duration(milliseconds: 300));
            
            if (navigatorState.mounted) {
              CircleNavigation.goToRegisterWithState(navigatorState, themeData);
            }
          },
          isSecondary: true,
          icon: Icons.person_add_rounded,
        ),
      ),
      slideDistance: 0.25,
    );
  }
}

// Clase ExploreButton eliminada ya que no se utiliza más

/// Controlador para el efecto parallax
/// Se define aquí para ser accesible desde ActionCard
class ParallaxController extends ChangeNotifier {
  double _dx = 0.0;
  double _dy = 0.0;
  bool _isAnimating = false;

  double get dx => _dx;
  double get dy => _dy;

  // Animación de movimiento sutil para el fondo
  void animateForward() {
    if (_isAnimating) return;
    _isAnimating = true;

    // Mover ligeramente el fondo al azar
    final random = DateTime.now().millisecondsSinceEpoch % 100 / 1000;
    _dx = random - 0.05;
    _dy = (random / 2) - 0.025;
    notifyListeners();

    // Volver a la posición original después
    Future.delayed(const Duration(milliseconds: 800), () {
      _dx = 0.0;
      _dy = 0.0;
      notifyListeners();
      _isAnimating = false;
    });
  }
}
