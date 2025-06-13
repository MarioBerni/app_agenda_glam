import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';

/// Componente modular que representa el encabezado de la página de bienvenida
/// con animaciones sofisticadas y elementos visuales mejorados.
class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icono principal con efecto shimmer mejorado
        GlamAnimations.applyEntryEffect(
          const GlamIconContainer(
            icon: Icons.content_cut_outlined, // Cambiado a outlined para un aspecto más elegante
            size: 95, // Ligeramente más grande para mejor visibilidad
            backgroundColor: Color(0xFF0A2040), // Azul oscuro más rico
            iconColor: Color(0xFFFFDA00), // Amarillo dorado más brillante
            enableShimmer: true,
            animateEntry: true,
          ),
          slideDistance: 0.3,
          duration: const Duration(milliseconds: 1200),
        ),
        
        const SizedBox(height: 16),
        
        // Título con animación de aparición más sofisticada
        GlamAnimations.applyEntryEffect(
          const Text(
            'AGENDA GLAM',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 3.0,
            ),
            textAlign: TextAlign.center,
          ),
          slideDistance: 0.25,
          duration: const Duration(milliseconds: 1000),
        ),
      
        const SizedBox(height: 8),
        
        // Tagline con animación suave
        GlamAnimations.applyEntryEffect(
          const Text(
            'ESTILO Y ELEGANCIA MASCULINA',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kAccentColor,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          slideDistance: 0.2,
          duration: const Duration(milliseconds: 1000),
        ),
      ],
    );
  }
}
