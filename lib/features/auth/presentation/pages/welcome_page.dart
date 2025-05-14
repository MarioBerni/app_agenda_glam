import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_logo.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_video_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget para efecto parallax en el fondo
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
          offset: Offset(
            controller.dx * 15,
            controller.dy * 15,
          ),
          child: child,
        );
      },
    );
  }
}

// Controlador para el efecto parallax
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

  @override
  void dispose() {
    super.dispose();
  }
}

/// Página de bienvenida que muestra opciones para login o registro
/// con diseño visual mejorado y animaciones fluidas
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Controlador para animación del fondo parallax
  final _parallaxController = ParallaxController();

  @override
  void dispose() {
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Eliminar el color de fondo ya que lo proporciona GlamBackground
      backgroundColor: Colors.transparent,
      // Aplicar contenido dentro de un Stack para usar nuestro fondo personalizado
      body: Stack(
        children: [
          // Video de fondo con degradado elegante y efecto parallax
          ParallaxBackground(
            controller: _parallaxController,
            child: const GlamVideoBackground(
              videoAsset: 'assets/videos/welcome_background.mp4',
              gradientOpacity: 0.9,  // Aumentamos la opacidad para un efecto más visible
              gradientColor: kPrimaryColor, // Usamos el color primario más oscuro
            ),
          ),
          
          // Contenido principal con SafeArea
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),
                  
                  // Logo con animaciones mejoradas
                  GlamAnimations.applyLogoEffect(
                    const GlamLogo(
                      size: 110,
                      showTagline: true,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Contenido con animaciones escalonadas
                  Column(
                      children: [
                        // Mensaje de bienvenida con animación de entrada
                        GlamAnimations.applyEntryEffect(
                          Text(
                            'Bienvenido',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          slideDistance: 0.1,
                        ),
                        const SizedBox(height: 16),
                        // Texto descriptivo con animación retrasada
                        GlamAnimations.applyEntryEffect(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Tu plataforma para descubrir y reservar los mejores servicios de estética masculina',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          slideDistance: 0.15,
                        ),
                        
                        const SizedBox(height: 48),
                        
                        // Botón de inicio de sesión con efectos visuales mejorados
                        GlamAnimations.applyEntryEffect(
                          Hero(
                            tag: 'login_button', // Para animación hero en transición
                            child: GlamButton(
                              text: 'Iniciar Sesión',
                              onPressed: () {
                                // Animación de cambio de página
                                _parallaxController.animateForward();
                                Future.delayed(const Duration(milliseconds: 300), () {
                                  context.go(AppRouter.login);
                                });
                              },
                              icon: Icons.login_rounded,
                              withShimmer: true, // Efecto visual adicional
                            ),
                          ),
                          slideDistance: 0.2,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Botón de registro con animación de entrada
                        GlamAnimations.applyEntryEffect(
                          Hero(
                            tag: 'register_button', // Para animación hero en transición
                            child: GlamButton(
                              text: 'Registrarse',
                              onPressed: () {
                                // Animación de cambio de página
                                _parallaxController.animateForward();
                                Future.delayed(const Duration(milliseconds: 300), () {
                                  context.go(AppRouter.register);
                                });
                              },
                              isSecondary: true,
                              icon: Icons.person_add_rounded,
                            ),
                          ),
                          slideDistance: 0.25,
                        ),
                      ],
                    ),
                  
                  SizedBox(height: size.height * 0.08),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
