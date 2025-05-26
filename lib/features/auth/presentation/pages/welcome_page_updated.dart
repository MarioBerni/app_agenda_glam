import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_video_background.dart';
import 'package:app_agenda_glam/features/partners/data/models/partner_data.dart';
import 'package:app_agenda_glam/features/partners/presentation/widgets/partners_carousel.dart';
import 'package:flutter/material.dart';

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
          offset: Offset(controller.dx * 15, controller.dy * 15),
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

  // No necesitamos sobrescribir dispose() si solo llamamos a super.dispose()
  // El analizador recomienda eliminar overrides innecesarios
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
    return Scaffold(
      // Fondo transparente porque el video background proporciona el fondo
      backgroundColor: Colors.transparent,
      // Aplicar contenido dentro de un Stack para usar nuestro fondo personalizado
      body: Stack(
        children: [
          // Video de fondo con degradado elegante y efecto parallax
          ParallaxBackground(
            controller: _parallaxController,
            child: const GlamVideoBackground(
              videoAsset: 'assets/videos/welcome_background.mp4',
              gradientOpacity:
                  0.9, // Aumentamos la opacidad para un efecto más visible
              gradientColor:
                  kPrimaryColor, // Usamos el color primario más oscuro
            ),
          ),

          // Contenido principal con SafeArea
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda para los títulos
                  children: [
                    // Ícono y título centrados
                    Center(
                      child: Column(
                        children: [
                          // Ícono de tijera simplificado
                          const GlamIconContainer(
                            icon: Icons.content_cut_rounded,
                            size: 80,
                            enableShimmer: true,
                            animateEntry: true,
                          ),
                          
                          // Título principal con animación de entrada
                          GlamAnimations.applyEntryEffect(
                            const Text(
                              'Agenda Glam',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      
                          // Tagline con espacio reducido
                          const SizedBox(height: 8),
                          GlamAnimations.applyEntryEffect(
                            const Text(
                              'Tu agenda de belleza masculina',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            slideDistance: 0.15,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Título de sección con animación
                    GlamAnimations.applyEntryEffect(
                      const Text(
                        'Socios destacados',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      slideDistance: 0.15,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Carrusel de socios con diseño mejorado
                    SizedBox(
                      height: 180,
                      child: GlamAnimations.applyEntryEffect(
                        PartnersCarousel(
                          partners: PartnerData.getSamplePartners(),
                          autoScrollDuration: const Duration(seconds: 3),
                          height: 180,
                        ),
                        slideDistance: 0.2,
                        duration: const Duration(milliseconds: 800),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Título de sección con animación
                    GlamAnimations.applyEntryEffect(
                      const Text(
                        'Servicios populares',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      slideDistance: 0.15,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Sección de servicios populares
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildServiceItem(Icons.content_cut, 'Corte de pelo'),
                          _buildServiceItem(Icons.face, 'Barba'),
                          _buildServiceItem(Icons.spa, 'Facial'),
                          _buildServiceItem(Icons.color_lens, 'Coloración'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Card de llamada a la acción (similar a la página de exploración)
                    GlamAnimations.applyEntryEffect(
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: ColorUtils.withOpacityValue(kSurfaceColor, 0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: ColorUtils.withOpacityValue(kAccentColor, 0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Comienza tu experiencia',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Accede a todas las funcionalidades y reserva tu próxima cita de estética masculina',
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorUtils.withOpacityValue(Colors.white, 0.8),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Botones de inicio de sesión y registro dentro de la card
                  
                            GlamAnimations.applyEntryEffect(
                              Hero(
                                tag: 'login_button',
                                child: GlamButton(
                                  text: 'Iniciar Sesión',
                                  onPressed: () async {
                                    _parallaxController.animateForward();
                                    final navigatorState = Navigator.of(context);
                                    final themeData = Theme.of(context);
                                    
                                    await Future.delayed(const Duration(milliseconds: 300));
                                    
                                    if (mounted) {
                                      CircleNavigation.goToLoginWithState(navigatorState, themeData);
                                    }
                                  },
                                  icon: Icons.login_rounded,
                                  withShimmer: true,
                                ),
                              ),
                              slideDistance: 0.2,
                            ),
                            
                            const SizedBox(height: 12),
                            
                            GlamAnimations.applyEntryEffect(
                              Hero(
                                tag: 'register_button',
                                child: GlamButton(
                                  text: 'Registrarse',
                                  onPressed: () async {
                                    _parallaxController.animateForward();
                                    final navigatorState = Navigator.of(context);
                                    final themeData = Theme.of(context);
                                    
                                    await Future.delayed(const Duration(milliseconds: 300));
                                    
                                    if (mounted) {
                                      CircleNavigation.goToRegisterWithState(navigatorState, themeData);
                                    }
                                  },
                                  isSecondary: true,
                                  icon: Icons.person_add_rounded,
                                ),
                              ),
                              slideDistance: 0.25,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Botón para experimentar sin registro debajo de la card
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                        child: GlamAnimations.applyEntryEffect(
                          TextButton(
                            onPressed: () {
                              // Esta opción se mantiene pero ya no navega a otra página
                              // Ya que la información relevante está ahora en la página de bienvenida
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('¡Ya estás explorando! Desplázate para ver más contenido.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Text(
                              'Experimentar sin registro',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          slideDistance: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir cada ítem de servicio
  Widget _buildServiceItem(IconData icon, String name) {
    return GlamAnimations.applyEntryEffect(
      Container(
        width: 90,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: ColorUtils.withOpacityValue(kSurfaceColor, 0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: kAccentColor,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      // Usamos duración manual para escalonar los elementos
      duration: const Duration(milliseconds: 800),
    );
  }
}
