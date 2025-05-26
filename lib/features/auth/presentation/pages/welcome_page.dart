import 'package:app_agenda_glam/features/auth/presentation/widgets/action_card.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/featured_partners_section.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_video_background.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/welcome_header.dart';
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

/// Página de bienvenida que muestra opciones para login o registro
/// con diseño visual mejorado y animaciones fluidas.
/// 
/// La página ha sido refactorizada en componentes modulares para mejorar
/// la mantenibilidad y seguir los principios de arquitectura limpia.
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
              gradientOpacity: 0.9, // Aumentamos la opacidad para un efecto más visible
            ),
          ),

          // Contenido principal con SafeArea y ScrollView para evitar desbordamiento
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Encabezado con logo, título y tagline
                    const WelcomeHeader(),
                    
                    const SizedBox(height: 24),
                    
                    // Sección de socios destacados con carrusel
                    const FeaturedPartnersSection(),
                    
                    const SizedBox(height: 24),
                    
                    // Card de acción con botones de login y registro
                    ActionCard(parallaxController: _parallaxController),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}