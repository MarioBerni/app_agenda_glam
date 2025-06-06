import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';

/// Widget que muestra el texto informativo y los botones de inicio de sesión y registro
/// o una tarjeta de acción personalizada con gradiente de colores
class ActionCard extends StatelessWidget {
  final ParallaxController? parallaxController;
  
  // Propiedades para el constructor fromColor
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;
  final Alignment? gradientBegin;
  final Alignment? gradientEnd;
  final bool isColorVariant;
  
  /// Constructor estándar para la tarjeta de acción de login/registro
  const ActionCard({
    super.key,
    required this.parallaxController,
  }) : icon = null,
       title = null,
       subtitle = null,
       onTap = null,
       gradientColors = null,
       gradientBegin = null,
       gradientEnd = null,
       isColorVariant = false;
       
  /// Constructor para crear una tarjeta de acción con colores personalizados
  /// Útil para páginas de bienvenida y navegación principal
  const ActionCard.fromColor({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  }) : parallaxController = null,
       isColorVariant = true;

  @override
  Widget build(BuildContext context) {
    // Renderizar tarjeta de acción con colores personalizados
    if (isColorVariant) {
      return _buildColorCard();
    }
    
    // Renderizar tarjeta de login/registro estándar
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
            parallaxController?.animateForward();
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
            parallaxController?.animateForward();
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
  
  /// Construye una tarjeta de acción con colores personalizados según los parámetros
  Widget _buildColorCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: gradientColors ?? [Colors.purple, Colors.deepPurple],
            begin: gradientBegin ?? Alignment.topLeft,
            end: gradientEnd ?? Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: (gradientColors?.first ?? Colors.purple).withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono
            Icon(
              icon ?? Icons.star,
              color: Colors.white,
              size: 32,
            ),
            
            const SizedBox(height: 16),
            
            // Título
            Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
            
            const SizedBox(height: 4),
            
            // Subtítulo
            Text(
              subtitle ?? '',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
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
